#################################
#OIDC APPLICATIONS
#################################
module "oidc_apps" {
  source = "./modules/oidc_app"

  for_each = var.oidc_apps

  label            = each.value.label
  application_type = each.value.application_type
  grant_types      = each.value.grant_types
  response_types   = each.value.application_type == "service" ? [] : each.value.response_types

  redirect_uris = each.value.application_type == "service" ? [] : concat(each.value.redirect_uris_test, each.value.redirect_uris_prod)

  post_logout_redirect_uris = each.value.application_type == "service" ? [] : each.value.post_logout_redirect_uris
  consent_method            = each.value.consent_method
  issuer_mode               = each.value.issuer_mode
  refresh_token_rotation    = each.value.refresh_token_rotation
}

####################################
#SAML APPLICATIONS
####################################
module "saml_apps" {
  source = "./modules/saml_app"

  for_each = var.saml_apps

  label       = each.value.label
  sso_acs_url = each.value.sso_acs_url
  recipient   = each.value.recipient
  destination = each.value.destination
  audience    = each.value.audience
  idp_issuer  = each.value.idp_issuer

  subject_name_id_template = each.value.subject_name_id_template
  subject_name_id_format   = each.value.subject_name_id_format

  response_signed  = each.value.response_signed
  assertion_signed = each.value.assertion_signed

  signature_algorithm = each.value.signature_algorithm
  digest_algorithm    = each.value.digest_algorithm

  honor_force_authn       = each.value.honor_force_authn
  authn_context_class_ref = each.value.authn_context_class_ref

  attribute_statements = each.value.attribute_statements
}

#################################
# Auth Servers (one per OIDC app)
#################################
# Prepare input map for Auth Server module
locals {
  auth_server_apps = {
    for k, app in module.oidc_apps :
    k => {
      app_key   = k
      client_id = app.client_id
    }
  }
}


module "auth_servers" {
  for_each   = local.auth_server_apps
  source     = "./modules/auth_server"
  client_id  = each.value.client_id
  app_key    = each.value.app_key
}
