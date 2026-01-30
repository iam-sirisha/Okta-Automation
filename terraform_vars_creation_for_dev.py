import os, json, re, shutil, stat
from urllib.parse import urlparse
from typing import Any, Dict, List, Optional, Tuple, cast

ROOT_REPO_PATH = os.path.abspath("./Test-Okta-Config/OKTA")
INDEX_PATH = os.path.join(ROOT_REPO_PATH, "index.json")

TF_OUT_DIR = os.path.abspath("./terraform-okta/tf_inputs")
SAML_TFVARS_PATH = os.path.join(TF_OUT_DIR, "saml_apps.tfvars")
OIDC_TFVARS_PATH = os.path.join(TF_OUT_DIR, "oauth_apps.tfvars")

SAML_MAP_NAME = "saml_apps"
OIDC_MAP_NAME = "oidc_apps"

def reset_dir(p: str) -> None:
    if os.path.isdir(p):
        def _onerr(func, path, exc_info):
            try: os.chmod(path, stat.S_IWRITE)
            except Exception: pass
            try: func(path)
            except Exception: pass
        shutil.rmtree(p, onerror=_onerr)
        print(f"Removed: {p}")
    os.makedirs(p, exist_ok=True)
    print(f"Created: {p}")

def read_json(path: str) -> Any:
    with open(path, "r", encoding="utf-8") as f:
        return json.load(f)

def load_app_file(index_dir: str, rel_file: str) -> Dict[str, Any]:
    abs_path = os.path.join(index_dir, rel_file)
    if not os.path.isfile(abs_path):
        return {}
    data = read_json(abs_path)
    return cast(Dict[str, Any], data if isinstance(data, dict) else {})

def safe_key(label: str) -> str:
    s = str(label or "").strip()
    s = re.sub(r"[^\w\-. ]+", "_", s)
    s = re.sub(r"\s+", "_", s)
    if not s: s = "unnamed"
    s = s.replace("-", "_").replace(".", "_")
    return s

def is_test_like(host: str) -> bool:
    h = (host or "").lower()
    return any(x in h for x in ["test", "dev", "preprod", "staging", "stage", "qa"]) or h.startswith(("stg", "qa"))

def split_redirects(uris: List[str]) -> Tuple[List[str], List[str]]:
    test_list: List[str] = []
    prod_list: List[str] = []
    for u in uris:
        try:
            host = urlparse(u).hostname or ""
        except Exception:
            host = ""
        (test_list if is_test_like(host) else prod_list).append(u)
    if not prod_list and (test_list or uris):
        prod_list = uris[:]
        test_list = []
    return test_list, prod_list

def tf_quote(s: str) -> str:
    return '"' + s.replace("\\", "\\\\").replace('"', '\\"') + '"'

def tf_list_str(items: List[str]) -> str:
    return "[" + ", ".join(tf_quote(i) for i in items) + "]"

def emit_tf_map(path: str, var_name: str, entries: Dict[str, Dict[str, Any]]) -> None:
    lines: List[str] = []
    lines.append(f"{var_name} = {{")
    for key, obj in entries.items():
        lines.append(f"  {key} = {{")
        order = obj.get("_order", [])
        for k in order:
            v = obj.get(k)
            if v is None: continue
            if isinstance(v, bool):
                lines.append(f"    {k} = {str(v).lower()}")
            elif isinstance(v, list):
                lines.append(f"    {k} = {tf_list_str([str(x) for x in v])}")
            else:
                lines.append(f"    {k} = {tf_quote(str(v))}")
        for k, v in obj.items():
            if k == "_order" or k in order: continue
            if v is None: continue
            if isinstance(v, bool):
                lines.append(f"    {k} = {str(v).lower()}")
            elif isinstance(v, list):
                lines.append(f"    {k} = {tf_list_str([str(x) for x in v])}")
            else:
                lines.append(f"    {k} = {tf_quote(str(v))}")
        lines.append("  }")
    lines.append("}")
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))
    print(f"Wrote {path}")

def extract_saml_tfvars(app: Dict[str, Any]) -> Optional[Dict[str, Any]]:
    settings = cast(Dict[str, Any], app.get("settings") or {})
    signon = cast(Dict[str, Any], settings.get("signOn") or {})
    sso_acs = cast(str, signon.get("ssoAcsUrl") or "")
    audience = cast(str, signon.get("audience") or signon.get("spIssuer") or "")
    if not sso_acs or not audience:
        return None
    label = cast(str, app.get("label") or app.get("name") or "SAML App")
    recipient = cast(str, signon.get("recipient") or sso_acs)
    destination = cast(str, signon.get("destination") or sso_acs)
    subject_tpl = cast(str, signon.get("subjectNameIdTemplate") or "${user.userName}")
    subject_fmt = cast(str, signon.get("subjectNameIdFormat") or "urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified")
    resp_signed = bool(signon.get("responseSigned", True))
    asrt_signed = bool(signon.get("assertionSigned", True))
    sig_alg = cast(str, signon.get("signatureAlgorithm") or "RSA_SHA256")
    dig_alg = cast(str, signon.get("digestAlgorithm") or "SHA256")
    honor_force_authn = bool(signon.get("honorForceAuthn", True))
    authn_context = cast(str, signon.get("authnContextClassRef") or "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport")

    attr_statements: List[Dict[str, Any]] = []
    raw_attrs = signon.get("attributeStatements")
    if isinstance(raw_attrs, list):
        for a in raw_attrs:
            if not isinstance(a, dict): continue
            if "filterType" in a or "filterValue" in a or str(a.get("type", "")).upper() == "GROUP":
                attr_statements.append({
                    "type": "GROUP",
                    "name": cast(str, a.get("name") or ""),
                    "namespace": cast(str, a.get("namespace") or "urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified"),
                    "filter_type": cast(str, a.get("filterType") or a.get("filter_type") or "STARTS_WITH"),
                    "filter_value": cast(str, a.get("filterValue") or a.get("filter_value") or ""),
                })
            else:
                values = []
                if isinstance(a.get("values"), list) and a["values"]:
                    values = [str(x) for x in a["values"] if isinstance(x, str)]
                elif isinstance(a.get("expression"), str) and a["expression"]:
                    values = [a["expression"]]
                attr_statements.append({
                    "type": "EXPRESSION",
                    "name": cast(str, a.get("name") or ""),
                    "namespace": cast(str, a.get("namespace") or "urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified"),
                    "values": values or ["user.email"],
                })

    return {
        "_order": [
            "label","sso_acs_url","recipient","destination","audience","idp_issuer",
            "subject_name_id_template","subject_name_id_format","response_signed",
            "assertion_signed","signature_algorithm","digest_algorithm",
            "honor_force_authn","authn_context_class_ref","attribute_statements",
        ],
        "label": label,
        "sso_acs_url": sso_acs,
        "recipient": recipient,
        "destination": destination,
        "audience": audience,
        "idp_issuer": "http://www.okta.com/$${org.externalKey}",
        "subject_name_id_template": subject_tpl.replace("${", "$${"),
        "subject_name_id_format": subject_fmt,
        "response_signed": resp_signed,
        "assertion_signed": asrt_signed,
        "signature_algorithm": sig_alg,
        "digest_algorithm": dig_alg,
        "honor_force_authn": honor_force_authn,
        "authn_context_class_ref": authn_context,
        "attribute_statements": attr_statements,
    }

def extract_oidc_tfvars(app: Dict[str, Any]) -> Optional[Dict[str, Any]]:
    label = cast(str, app.get("label") or app.get("name") or "OIDC App")
    settings = cast(Dict[str, Any], app.get("settings") or {})
    oc = cast(Dict[str, Any], settings.get("oauthClient") or {})

    app_type = cast(str, oc.get("application_type") or "").lower()
    if app_type not in ("web", "browser", "service", "native"):
        return None
    application_type = "web" if app_type in ("web", "browser", "native") else "service"

    redirect_uris = cast(List[str], oc.get("redirect_uris") or [])
    post_logout_redirect_uris = cast(List[str], oc.get("post_logout_redirect_uris") or [])

    grants = [str(x) for x in cast(List[str], oc.get("grant_types") or [])]
    if not grants:
        grants = ["client_credentials"] if application_type == "service" else ["authorization_code"]

    # Response types:
    if application_type == "service":
        responses: List[str] = []
    else:
        responses = [str(x) for x in cast(List[str], oc.get("response_types") or [])] or ["code"]

    test_uris, prod_uris = split_redirects(redirect_uris)
    combined_redirects = [*test_uris, *prod_uris]

    # Enforce at least one redirect for web + auth code
    if application_type == "web" and any(g.lower() == "authorization_code" for g in grants):
        if not combined_redirects:
            # Try to salvage from common localhost defaults if present in post logout
            # but if still empty, skip to avoid 400
            print(f"Skipping OIDC app '{label}': no redirect_uris found for authorization_code grant.")
            return None

    token_endpoint_auth_method = cast(str, oc.get("token_endpoint_auth_method") or (
        "client_secret_basic" if application_type in ("web", "service","native") else "none"
    ))
    consent_method = cast(str, oc.get("consent_method") or "TRUSTED")
    issuer_mode = cast(str, oc.get("issuer_mode") or "ORG_URL")
    has_refresh_grant = any(g.lower() == "refresh_token" for g in grants)
    refresh_rotation = cast(str, oc.get("refresh_token_rotation") or ("ROTATE" if has_refresh_grant else "STATIC"))

    out: Dict[str, Any] = {
        "_order": [
            "label","application_type","grant_types","response_types",
            "redirect_uris","redirect_uris_test","redirect_uris_prod",
            "post_logout_redirect_uris","consent_method","issuer_mode",
            "refresh_token_rotation","token_endpoint_auth_method",
        ],
        "label": label,
        "application_type": application_type,
        "grant_types": grants,
        "response_types": responses,
        # Provide a combined field most modules map directly to okta_app_oauth.redirect_uris
        "redirect_uris": combined_redirects,
        # Also keep split fields if your module expects them
        "redirect_uris_test": test_uris,
        "redirect_uris_prod": prod_uris,
        "post_logout_redirect_uris": post_logout_redirect_uris,
        "consent_method": consent_method,
        "issuer_mode": issuer_mode,
        "refresh_token_rotation": refresh_rotation,
        "token_endpoint_auth_method": token_endpoint_auth_method,
    }

    # Service apps must not have redirect URIs
    if application_type == "service":
        out["redirect_uris"] = []
        out["redirect_uris_test"] = []
        out["redirect_uris_prod"] = []
        out["post_logout_redirect_uris"] = []

    return out

def main() -> None:
    if not os.path.isfile(INDEX_PATH):
        raise SystemExit(f"Missing {INDEX_PATH}. Run DEV backup first: {INDEX_PATH}")

    reset_dir(TF_OUT_DIR)
    index = read_json(INDEX_PATH)
    index_dir = os.path.dirname(INDEX_PATH)
    apps = cast(List[Dict[str, Any]], index.get("apps") or [])

    saml_map: Dict[str, Dict[str, Any]] = {}
    oidc_map: Dict[str, Dict[str, Any]] = {}

    for entry in apps:
        rel = entry.get("file")
        if not isinstance(rel, str) or not rel:
            continue
        app = load_app_file(index_dir, rel)
        sign_on_mode = str(app.get("signOnMode") or entry.get("signOnMode") or "").upper()
        label = cast(str, app.get("label") or app.get("name") or "App")
        key = safe_key(label)

        if sign_on_mode == "SAML_2_0":
            saml = extract_saml_tfvars(app)
            if saml:
                saml_map[key] = saml
        elif sign_on_mode == "OPENID_CONNECT":
            oidc = extract_oidc_tfvars(app)
            if oidc:
                oidc_map[key] = oidc

    if saml_map:
        emit_tf_map(SAML_TFVARS_PATH, SAML_MAP_NAME, saml_map)
    else:
        print("No SAML apps found to emit.")
    if oidc_map:
        emit_tf_map(OIDC_TFVARS_PATH, OIDC_MAP_NAME, oidc_map)
    else:
        print("No OIDC apps found to emit.")

if __name__ == "__main__":
    main()
