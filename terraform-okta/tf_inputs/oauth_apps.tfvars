oidc_apps = {
  My_Web_App = {
    label = "My Web App"
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
  }
  Test_App2 = {
    label = "Test-App2"
    application_type = "web"
    grant_types = ["authorization_code"]
    response_types = ["code"]
    redirect_uris = ["https://test.reporting.com/callback"]
    redirect_uris_test = []
    redirect_uris_prod = ["https://test.reporting.com/callback"]
    post_logout_redirect_uris = ["https://reporting.com"]
    consent_method = "REQUIRED"
    issuer_mode = "DYNAMIC"
    refresh_token_rotation = "STATIC"
    token_endpoint_auth_method = "client_secret_basic"
  }
  Test_App1 = {
    label = "Test-App1"
    application_type = "web"
    grant_types = ["authorization_code", "refresh_token"]
    response_types = ["code"]
    redirect_uris = ["https://test.example.com/callback"]
    redirect_uris_test = []
    redirect_uris_prod = ["https://test.example.com/callback"]
    post_logout_redirect_uris = ["https://example.com"]
    consent_method = "TRUSTED"
    issuer_mode = "ORG_URL"
    refresh_token_rotation = "ROTATE"
    token_endpoint_auth_method = "client_secret_basic"
  }
}