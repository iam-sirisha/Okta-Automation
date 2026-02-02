  oidc_apps = {
  APP3535693_PCF_RELEASE = {
    label = "APP3535693-PCF RELEASE"
    application_type = "web"
    grant_types = ["authorization_code"]
    response_types = ["code"]
    redirect_uris = ["http://localhost:8080/authorization-code/callback"]
    redirect_uris_test = []
    redirect_uris_prod = ["http://localhost:8080/authorization-code/callback"]
    post_logout_redirect_uris = ["http://localhost:8080"]
    consent_method = "REQUIRED"
    issuer_mode = "DYNAMIC"
    refresh_token_rotation = "STATIC"
    token_endpoint_auth_method = "client_secret_basic"
    authserver_name           = "APP3535693"
    auth_policy_name          = "Standard OIDC Access Policy"
    auth_policy_rule_name     = "Standard OIDC Access Policy Rule"
    auth_grant_type_whitelist = ["authorization_code"]
  }
  My_API_Services_App__Service = {
    label = "My API Services App- Service"
    application_type = "service"
    grant_types = ["client_credentials"]
    response_types = []
    redirect_uris = []
    redirect_uris_test = []
    redirect_uris_prod = []
    post_logout_redirect_uris = []
    consent_method = "REQUIRED"
    issuer_mode = "DYNAMIC"
    refresh_token_rotation = "STATIC"
    token_endpoint_auth_method = "client_secret_basic"
    authserver_name           = "My_API_Services_App"
    auth_policy_name          = "Standard OIDC Access Policy"
    auth_policy_rule_name     = "Standard OIDC Access Policy Rule"
    auth_grant_type_whitelist = ["authorization_code"]
  }
  }
