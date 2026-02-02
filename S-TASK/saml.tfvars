saml_apps = {
  APP3535876_MDA_L1 = {
    label = "APP3535876-MDA-L1"
    sso_acs_url = "https://ocuil1wm1.logistics.fedex.com:11001/"
    recipient = "https://ocuil1wm1.logistics.fedex.com:11001/"
    destination = "https://ocuil1wm1.logistics.fedex.com:11001/"
    audience = "mda"
    idp_issuer = "http://www.okta.com/$${org.externalKey}"
    subject_name_id_template = "$${user.userName}"
    subject_name_id_format = "urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified"
    response_signed = true
    assertion_signed = true
    signature_algorithm = "RSA_SHA256"
    digest_algorithm = "SHA256"
    honor_force_authn = true
    authn_context_class_ref = "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport"
    attribute_statements = []
  }
}
