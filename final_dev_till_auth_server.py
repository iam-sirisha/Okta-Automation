import os
import sys
import json
import time
import shutil
import stat
import re
from typing import Any, Dict, List, Optional, Set, TypedDict, cast
import requests

# ===== Fixed destination root =====
ROOT_REPO_PATH = os.path.abspath("./OKTA")

# ===== Okta env =====
OKTA_DOMAIN_ENV = "OKTA_DOMAIN"       
OKTA_TOKEN_ENV  = "OKTA_API_TOKEN"

# ===== HTTP/config =====
REQUEST_TIMEOUT: int = 60
PAGE_LIMIT: int = 200
RETRY_COUNT: int = 3
RETRY_BACKOFF_SEC: int = 2

# ===== Exclusions =====
EXCLUDE_APP_NAMES: Set[str] = {
    "okta_enduser",
    "saasure",
    "okta_browser_plugin",
    "okta_flow_sso",
    "flow",
    "okta_iga_reviewer",
    "okta_access_requests_resource_catalog",
    "okta_atspoke_sso",
    "demo platform management",
    "partner admin portal"
}
APP_BLOCKLIST_LOWER: Set[str] = {
    "demo_platform_management",
}

EXCLUDE_AUTH_POLICIES: Set[str] = {
    "okta account management policy",
    "default policy",
    "okta dashboard",
    "okta browser plugin",
    "okta admin console",
}

OKTA_MANAGED_AUTHZ = {"default", "demo platform management"}
OKTA_MANAGED_PREFIXES = ("okta ",)

# ===== Auth policy types =====
AUTH_POLICY_TYPES = ["OKTA_SIGN_ON", "PASSWORD","ACCESS_POLICY"]
AUTH_POLICY_PATH = "auth-policies"

# ===== Strongly-typed records =====
class AppIndexEntry(TypedDict, total=False):
    id: str
    label: str
    name: str
    signOnMode: str
    category: Optional[str]
    file: str
    clientIds: List[str]

class AuthzEntry(TypedDict, total=False):
    id: str
    name: str
    issuer: Optional[str]
    default: Optional[bool]
    status: Optional[str]
    file: str
    policies: List[Dict[str, Any]]  # policy + rules

# ===== Paths =====
def build_paths(root_repo: str) -> Dict[str, str]:
    return {
        "apps_saml": os.path.join(root_repo, "applications", "saml"),
        "apps_web": os.path.join(root_repo, "applications", "web_type_apps"),
        "apps_service": os.path.join(root_repo, "applications", "service_type_apps"),
        "apps_native": os.path.join(root_repo, "applications", "native_type_apps"),
        "apps_spa": os.path.join(root_repo, "applications", "spa_type_apps"),
        "authz": os.path.join(root_repo, "auth-server-configs"),
        "auth_policy": os.path.join(root_repo, AUTH_POLICY_PATH),
        "index": os.path.join(root_repo, "index.json"),
    }


# ===== Utilities =====
def getenv_or_exit(name: str) -> str:
    v = os.environ.get(name)
    if not v:
        print(f"ERROR: Missing environment variable {name}", file=sys.stderr)
        sys.exit(2)
    return v

def ensure_dir(path: str) -> None:
    os.makedirs(path, exist_ok=True)

def _handle_remove_readonly(func, path, exc_info):
    try:
        os.chmod(path, stat.S_IWRITE)
    except Exception:
        pass
    try:
        func(path)
    except Exception:
        pass

def reset_root_repo(root_repo: str) -> None:
    if os.path.isdir(root_repo):
        try:
            shutil.rmtree(root_repo, onerror=_handle_remove_readonly)
        except Exception as e:
            print(f"Warning: Could not remove '{root_repo}' ({e}). Attempting to clean contents.", file=sys.stderr)
    ensure_dir(root_repo)

def http_get(url: str, headers: Dict[str, str]) -> requests.Response:
    last_err: Optional[Exception] = None
    for attempt in range(1, RETRY_COUNT + 1):
        try:
            resp = requests.get(url, headers=headers, timeout=REQUEST_TIMEOUT)
            if resp.status_code in (429, 500, 502, 503, 504):
                retry_after = int(resp.headers.get("Retry-After", "0") or 0)
                time.sleep(max(RETRY_BACKOFF_SEC * attempt, retry_after))
                continue
            return resp
        except requests.RequestException as e:
            last_err = e
            time.sleep(RETRY_BACKOFF_SEC * attempt)
    if last_err:
        raise last_err
    raise RuntimeError("GET failed without exception")

def paginate(url: str, headers: Dict[str, str]) -> List[Dict[str, Any]]:
    items: List[Dict[str, Any]] = []
    cur: Optional[str] = url
    while cur:
        r = http_get(cur, headers)
        if r.status_code != 200:
            raise RuntimeError(f"GET {cur} failed: {r.status_code} {r.text[:500]}")
        data = r.json()
        if isinstance(data, list):
            items.extend(cast(List[Dict[str, Any]], data))
        else:
            items.append(cast(Dict[str, Any], data))
        next_url: Optional[str] = None
        link = r.headers.get("Link")
        if isinstance(link, str):
            for part in (p.strip() for p in link.split(",")):
                if 'rel="next"' in part:
                    start = part.find("<") + 1
                    end = part.find(">")
                    if 0 < start < end:
                        next_url = part[start:end]
                        break
        cur = next_url
    return items

def safe_filename(name: str) -> str:
    s = str(name or "").strip()
    s = re.sub(r"[^\w\-. ]+", "_", s)
    s = re.sub(r"\s+", "_", s)
    if not s:
        s = "unnamed"
    return s

def write_json(path: str, data: Any) -> None:
    ensure_dir(os.path.dirname(path))
    with open(path, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=2, sort_keys=True, ensure_ascii=False)

def is_active(obj: Dict[str, Any]) -> bool:
    return str(obj.get("status") or "").upper() == "ACTIVE"

def is_excluded_app(app: Dict[str, Any]) -> bool:
    api_name = str(app.get("name") or "").strip().lower()
    label = str(app.get("label") or "").strip().lower()
    if api_name in EXCLUDE_APP_NAMES or label in EXCLUDE_APP_NAMES:
        return True
    if api_name in APP_BLOCKLIST_LOWER or label in APP_BLOCKLIST_LOWER:
        return True
    return False

# ===== App helpers =====
def classify_app_type(app: Dict[str, Any]) -> Optional[str]:
    sign_on = str(app.get("signOnMode") or "").upper()
    if sign_on == "SAML_2_0":
        return "saml"
    if sign_on == "OPENID_CONNECT":
        settings = cast(Dict[str, Any], app.get("settings") or {})
        oc = cast(Dict[str, Any], settings.get("oauthClient") or {})
        app_type = str(oc.get("application_type") or "").lower()
        if app_type in {"web", "browser"}:
            return "web"
        if app_type == "browser":
            return "spa"  
        if app_type == "service":
            return "service"
        if app_type == "native":
            return "native"
        return "web"
    return None

# ===== Apps backup =====
def backup_apps_to_repo(base_url: str, headers: Dict[str, str], paths: Dict[str, str]) -> List[AppIndexEntry]:
    apps = paginate(f"{base_url}/api/v1/apps?limit={PAGE_LIMIT}&filter=status eq \"ACTIVE\"", headers)
    index_entries: List[AppIndexEntry] = []

    for app in apps:
        if is_excluded_app(app) or not is_active(app):
            continue

        category = classify_app_type(app) or "web"
        label = str(app.get("label") or app.get("name") or app.get("id"))
        filename = f"{safe_filename(label)}.json"
        dest = os.path.join(paths[f"apps_{category}"], filename)
        write_json(dest, app)

        index_entries.append(AppIndexEntry(
            id=app.get("id"),
            label=label,
            name=str(app.get("name") or ""),
            signOnMode=str(app.get("signOnMode") or ""),
            category=category,
            file=os.path.relpath(dest, os.path.dirname(paths["index"])),
            clientIds=[]
        ))
        print(f"[Apps] Wrote {category}: {label} -> {dest}")
    return index_entries

# ===== Auth policies backup =====
def backup_auth_policies_to_repo(base_url: str, headers: Dict[str, str], paths: Dict[str, str]) -> List[Dict[str, Any]]:
    all_policies: List[Dict[str, Any]] = []
    ensure_dir(paths["auth_policy"])

    for ptype in AUTH_POLICY_TYPES:
        policies = paginate(f"{base_url}/api/v1/policies?type={ptype}&limit={PAGE_LIMIT}", headers)
        for p in policies:
            name = str(p.get("name") or "").lower()
            if not is_active(p) or name in EXCLUDE_AUTH_POLICIES:
                continue

            rules = paginate(f"{base_url}/api/v1/policies/{p['id']}/rules?limit={PAGE_LIMIT}", headers)
            rules_active = [r for r in rules if is_active(r)]
            policy_obj = {"policy": p, "rules": rules_active}
            fn = f"AUTH_POLICY_{safe_filename(p.get('name') or p['id'])}.json"
            dest = os.path.join(paths["auth_policy"], fn)
            write_json(dest, policy_obj)

            all_policies.append({
                "id": p["id"],
                "name": p.get("name"),
                "type": ptype,
                "status": p.get("status"),
                "file": os.path.relpath(dest, os.path.dirname(paths["index"]))
            })
            print(f"[AuthPolicy] Wrote {p.get('name')} -> {dest}")
    return all_policies

# ===== Authorization Servers backup =====
def backup_authz_to_repo(base_url: str, headers: Dict[str, str], paths: Dict[str, str]) -> List[AuthzEntry]:
    servers = paginate(f"{base_url}/api/v1/authorizationServers?limit={PAGE_LIMIT}", headers)
    entries: List[AuthzEntry] = []

    for s in servers:
        sid = str(s.get("id") or "")
        if not sid:
            continue
        name = str(s.get("name") or sid).strip()
        name_l = name.lower()
        if name_l in OKTA_MANAGED_AUTHZ or any(name_l.startswith(p) for p in OKTA_MANAGED_PREFIXES):
            print(f"[AuthZ] Skipping Okta-managed server: {name}")
            continue
        if not is_active(s):
            continue

        # Get policies
        policies = paginate(f"{base_url}/api/v1/authorizationServers/{sid}/policies?limit={PAGE_LIMIT}", headers)
        policies_active = []
        for p in policies:
            if not is_active(p):
                continue
            pid = str(p.get("id") or "")
            rules = paginate(f"{base_url}/api/v1/authorizationServers/{sid}/policies/{pid}/rules?limit={PAGE_LIMIT}", headers)
            rules_active = [r for r in rules if is_active(r)]
            policies_active.append({"policy": p, "rules": rules_active})

        fn = f"{safe_filename(name)}_AUTH_SERVER.json"
        dest = os.path.join(paths["authz"], fn)
        write_json(dest, {"server": s, "policies": policies_active})

        entries.append(AuthzEntry(
            id=sid,
            name=name,
            issuer=str(s.get("issuer") or ""),
            default=s.get("default"),
            status=s.get("status"),
            file=os.path.relpath(dest, os.path.dirname(paths["index"])),
            policies=policies_active
        ))
        print(f"[AuthZ] Wrote {name} -> {dest}")
    return entries

# ===== Main =====
def main() -> None:
    reset_root_repo(ROOT_REPO_PATH)
    paths = build_paths(ROOT_REPO_PATH)

    okta_domain = getenv_or_exit(OKTA_DOMAIN_ENV)
    okta_token = getenv_or_exit(OKTA_TOKEN_ENV)
    base_url = f"https://{okta_domain}"
    headers = {"Authorization": f"SSWS {okta_token}", "Accept": "application/json"}

    apps_index = backup_apps_to_repo(base_url, headers, paths)
    auth_policies = backup_auth_policies_to_repo(base_url, headers, paths)
    authz_entries = backup_authz_to_repo(base_url, headers, paths)

    index: Dict[str, Any] = {
        "root_repo": ROOT_REPO_PATH,
        "source_org": okta_domain,
        "generated_at": int(time.time()),
        "apps_count": len(apps_index),
        "auth_policies_count": len(auth_policies),
        "authz_count": len(authz_entries),
        "apps": apps_index,
        "auth_policies": auth_policies,
        "authz_servers": authz_entries
    }
    write_json(paths["index"], index)
    print(f"Done. Index: {paths['index']}")

if __name__ == "__main__":
    main()
