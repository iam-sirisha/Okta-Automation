oidc_app_rules = {
  myapp1 = {
    policy_name = "myapp1-policy"
    rules = [
      {
        name        = "auth-code-rule"
        grant_types = ["authorization_code"]
        scopes      = ["openid","profile","email"]
      }
    ]
  }
}