resource "okta_auth_server" "this" {
  name        = var.client_id
  description = "Authorization server for ${var.app_key}"
  audiences   = ["api://${var.client_id}"]
}

resource "okta_auth_server_policy" "this" {
  auth_server_id   = okta_auth_server.this.id
  name             = "${var.app_key}-policy"
  description      = "Access policy for ${var.app_key}"
  priority         = 1
  client_whitelist = [var.client_id]
}

resource "okta_auth_server_policy_rule" "this" {
  auth_server_id = okta_auth_server.this.id
  policy_id      = okta_auth_server_policy.this.id

  name                 = "default-rule"
  priority             = 1
  status               = "ACTIVE"
  grant_type_whitelist = ["client_credentials"]
  scope_whitelist      = ["*"]
}
