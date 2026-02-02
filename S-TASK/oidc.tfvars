oidc_apps = {
  "app3535693-pcf_release": {
    "app": {
      "id": "0oazn788v7fCyBfQZ697",
      "orn": "orn:okta:idp:00oye8z74hoxMErrs697:apps:oidc_client:0oazn788v7fCyBfQZ697",
      "name": "oidc_client",
      "label": "APP3535693-PCF RELEASE",
      "status": "ACTIVE",
      "lastUpdated": "2026-01-29T15:23:10.000Z",
      "created": "2026-01-29T15:23:09.000Z",
      "accessibility": {
        "selfService": false,
        "errorRedirectUrl": null,
        "loginRedirectUrl": null
      },
      "visibility": {
        "autoLaunch": false,
        "autoSubmitToolbar": false,
        "hide": {
          "iOS": true,
          "web": true
        },
        "appLinks": {
          "oidc_client_link": true
        }
      },
      "features": [],
      "signOnMode": "OPENID_CONNECT",
      "credentials": {
        "userNameTemplate": {
          "template": "${source.login}",
          "type": "BUILT_IN"
        },
        "signing": {
          "kid": "_SCqUs6pYBOo3ojX3Y79P6O7I8x3Rfit6JpD_7lIG2s"
        },
        "oauthClient": {
          "autoKeyRotation": true,
          "client_id": "0oazn788v7fCyBfQZ697",
          "token_endpoint_auth_method": "client_secret_basic",
          "pkce_required": false
        }
      },
      "universalLogout": {
        "status": "DISABLED",
        "supportType": "FULL",
        "identityStack": "NOT_SHARED",
        "protocol": "GLOBAL_TOKEN_REVOCATION"
      },
      "settings": {
        "app": {},
        "notifications": {
          "vpn": {
            "network": {
              "connection": "DISABLED"
            },
            "message": null,
            "helpUrl": null
          }
        },
        "manualProvisioning": false,
        "implicitAssignment": false,
        "emOptInStatus": "NONE",
        "notes": {
          "admin": null,
          "enduser": null
        },
        "oauthClient": {
          "client_uri": null,
          "logo_uri": null,
          "redirect_uris": [
            "http://localhost:8080/authorization-code/callback"
          ],
          "post_logout_redirect_uris": [
            "http://localhost:8080"
          ],
          "response_types": [
            "code"
          ],
          "grant_types": [
            "authorization_code"
          ],
          "application_type": "web",
          "consent_method": "REQUIRED",
          "issuer_mode": "DYNAMIC",
          "idp_initiated_login": {
            "mode": "DISABLED",
            "default_scope": []
          },
          "wildcard_redirect": "DISABLED",
          "dpop_bound_access_tokens": false
        }
      },
      "_links": {
        "uploadLogo": {
          "href": "https://demo-automation-terraform-12601.okta.com/api/v1/apps/0oazn788v7fCyBfQZ697/logo",
          "hints": {
            "allow": [
              "POST"
            ]
          }
        },
        "appLinks": [
          {
            "name": "oidc_client_link",
            "href": "https://demo-automation-terraform-12601.okta.com/home/oidc_client/0oazn788v7fCyBfQZ697/aln177a159h7Zf52X0g8",
            "type": "text/html"
          }
        ],
        "profileEnrollment": {
          "href": "https://demo-automation-terraform-12601.okta.com/api/v1/policies/rstye8z7cc0D7Ft6J697"
        },
        "policies": {
          "href": "https://demo-automation-terraform-12601.okta.com/api/v1/apps/0oazn788v7fCyBfQZ697/policies",
          "hints": {
            "allow": [
              "PUT"
            ]
          }
        },
        "groups": {
          "href": "https://demo-automation-terraform-12601.okta.com/api/v1/apps/0oazn788v7fCyBfQZ697/groups"
        },
        "logo": [
          {
            "name": "medium",
            "href": "https://ok14static.oktacdn.com/assets/img/logos/default.6770228fb0dab49a1695ef440a5279bb.png",
            "type": "image/png"
          }
        ],
        "clientCredentials": [
          {
            "name": "secrets",
            "href": "https://demo-automation-terraform-12601.okta.com/api/v1/apps/0oazn788v7fCyBfQZ697/credentials/secrets"
          }
        ],
        "accessPolicy": {
          "href": "https://demo-automation-terraform-12601.okta.com/api/v1/policies/rstzn8c9l8J9gZXh5697"
        },
        "users": {
          "href": "https://demo-automation-terraform-12601.okta.com/api/v1/apps/0oazn788v7fCyBfQZ697/users"
        },
        "deactivate": {
          "href": "https://demo-automation-terraform-12601.okta.com/api/v1/apps/0oazn788v7fCyBfQZ697/lifecycle/deactivate"
        }
      }
    },
    "authorization_servers": [
      {
        "server": {
          "id": "auszn8sc34OzBXd5g697",
          "name": "APP3535693",
          "description": "APP3535693",
          "audiences": [
            "APP3535693"
          ],
          "issuer": "https://demo-automation-terraform-12601.okta.com/oauth2/auszn8sc34OzBXd5g697",
          "issuerMode": "DYNAMIC",
          "status": "ACTIVE",
          "created": "2026-01-29T15:59:47.000Z",
          "lastUpdated": "2026-01-29T15:59:47.000Z",
          "credentials": {
            "signing": {
              "kid": "qUt38jPPhQJyS4_Yhpoh7_TEM0bTMCMuPDMTDSE6vGo",
              "rotationMode": "AUTO",
              "lastRotated": "2026-01-29T15:59:47.000Z",
              "nextRotation": "2026-04-29T15:59:47.000Z"
            }
          },
          "default": false,
          "_links": {
            "rotateKey": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8sc34OzBXd5g697/credentials/lifecycle/keyRotate",
              "hints": {
                "allow": [
                  "POST"
                ]
              }
            },
            "metadata": [
              {
                "name": "oauth-authorization-server",
                "href": "https://demo-automation-terraform-12601.okta.com/oauth2/auszn8sc34OzBXd5g697/.well-known/oauth-authorization-server",
                "hints": {
                  "allow": [
                    "GET"
                  ]
                }
              },
              {
                "name": "openid-configuration",
                "href": "https://demo-automation-terraform-12601.okta.com/oauth2/auszn8sc34OzBXd5g697/.well-known/openid-configuration",
                "hints": {
                  "allow": [
                    "GET"
                  ]
                }
              }
            ],
            "resourceServerCredentialsKeys": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8sc34OzBXd5g697/resourceservercredentials/keys",
              "hints": {
                "allow": [
                  "GET"
                ]
              }
            },
            "keys": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8sc34OzBXd5g697/credentials/keys",
              "hints": {
                "allow": [
                  "GET"
                ]
              }
            },
            "claims": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8sc34OzBXd5g697/claims",
              "hints": {
                "allow": [
                  "GET",
                  "POST"
                ]
              }
            },
            "policies": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8sc34OzBXd5g697/policies",
              "hints": {
                "allow": [
                  "GET",
                  "POST"
                ]
              }
            },
            "self": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8sc34OzBXd5g697",
              "hints": {
                "allow": [
                  "GET",
                  "DELETE",
                  "PUT"
                ]
              }
            },
            "scopes": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8sc34OzBXd5g697/scopes",
              "hints": {
                "allow": [
                  "GET",
                  "POST"
                ]
              }
            },
            "deactivate": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8sc34OzBXd5g697/lifecycle/deactivate",
              "hints": {
                "allow": [
                  "POST"
                ]
              }
            }
          }
        },
        "policy": {
          "id": "00pzn91ig0ElKFKOC697",
          "status": "ACTIVE",
          "name": "Standard OIDC Access Policy",
          "description": "Standard OIDC Access Policy",
          "priority": 1,
          "system": false,
          "conditions": {
            "clients": {
              "include": [
                "0oazn788v7fCyBfQZ697"
              ]
            }
          },
          "created": "2026-01-29T16:03:43.000Z",
          "lastUpdated": "2026-01-29T16:03:43.000Z",
          "_links": {
            "self": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8sc34OzBXd5g697/policies/00pzn91ig0ElKFKOC697",
              "hints": {
                "allow": [
                  "GET",
                  "PUT",
                  "DELETE"
                ]
              }
            },
            "rules": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8sc34OzBXd5g697/policies/00pzn91ig0ElKFKOC697/rules",
              "hints": {
                "allow": [
                  "GET"
                ]
              }
            },
            "deactivate": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8sc34OzBXd5g697/policies/00pzn91ig0ElKFKOC697/lifecycle/deactivate",
              "hints": {
                "allow": [
                  "POST"
                ]
              }
            }
          },
          "type": "OAUTH_AUTHORIZATION_POLICY"
        },
        "rules": [
          {
            "id": "0przn92vsqjsRP3fh697",
            "status": "ACTIVE",
            "name": "Standard OIDC Access Policy Rule",
            "priority": 1,
            "created": "2026-01-29T16:03:58.000Z",
            "lastUpdated": "2026-01-29T16:03:58.000Z",
            "system": false,
            "conditions": {
              "people": {
                "users": {
                  "include": [],
                  "exclude": []
                },
                "groups": {
                  "include": [
                    "EVERYONE"
                  ],
                  "exclude": []
                }
              },
              "grantTypes": {
                "include": [
                  "client_credentials",
                  "urn:ietf:params:oauth:grant-type:device_code",
                  "authorization_code"
                ]
              },
              "scopes": {
                "include": [
                  "*"
                ]
              }
            },
            "actions": {
              "token": {
                "accessTokenLifetimeMinutes": 60,
                "refreshTokenLifetimeMinutes": 480,
                "refreshTokenWindowMinutes": 480
              }
            },
            "_links": {
              "self": {
                "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8sc34OzBXd5g697/policies/00pzn91ig0ElKFKOC697/rules/0przn92vsqjsRP3fh697",
                "hints": {
                  "allow": [
                    "GET",
                    "PUT",
                    "DELETE"
                  ]
                }
              },
              "deactivate": {
                "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8sc34OzBXd5g697/policies/00pzn91ig0ElKFKOC697/rules/0przn92vsqjsRP3fh697/lifecycle/deactivate",
                "hints": {
                  "allow": [
                    "POST"
                  ]
                }
              }
            },
            "type": "RESOURCE_ACCESS"
          }
        ]
      }
    ],
    "source_folder": "web_type_apps"
  },
  "app3536352-cms": {
    "app": {
      "id": "0oazn6qv94X194IGC697",
      "orn": "orn:okta:idp:00oye8z74hoxMErrs697:apps:oidc_client:0oazn6qv94X194IGC697",
      "name": "oidc_client",
      "label": "APP3536352-CMS",
      "status": "ACTIVE",
      "lastUpdated": "2026-01-29T15:13:25.000Z",
      "created": "2026-01-29T15:13:24.000Z",
      "accessibility": {
        "selfService": false,
        "errorRedirectUrl": null,
        "loginRedirectUrl": null
      },
      "visibility": {
        "autoLaunch": false,
        "autoSubmitToolbar": false,
        "hide": {
          "iOS": true,
          "web": true
        },
        "appLinks": {
          "oidc_client_link": true
        }
      },
      "features": [],
      "signOnMode": "OPENID_CONNECT",
      "credentials": {
        "userNameTemplate": {
          "template": "${source.login}",
          "type": "BUILT_IN"
        },
        "signing": {
          "kid": "_SCqUs6pYBOo3ojX3Y79P6O7I8x3Rfit6JpD_7lIG2s"
        },
        "oauthClient": {
          "autoKeyRotation": true,
          "client_id": "0oazn6qv94X194IGC697",
          "token_endpoint_auth_method": "none",
          "pkce_required": true
        }
      },
      "universalLogout": {
        "status": "DISABLED",
        "supportType": "FULL",
        "identityStack": "NOT_SHARED",
        "protocol": "GLOBAL_TOKEN_REVOCATION"
      },
      "settings": {
        "app": {},
        "notifications": {
          "vpn": {
            "network": {
              "connection": "DISABLED"
            },
            "message": null,
            "helpUrl": null
          }
        },
        "manualProvisioning": false,
        "implicitAssignment": false,
        "emOptInStatus": "NONE",
        "notes": {
          "admin": null,
          "enduser": null
        },
        "oauthClient": {
          "client_uri": null,
          "logo_uri": null,
          "redirect_uris": [
            "http://localhost:8080/login/callback"
          ],
          "post_logout_redirect_uris": [
            "http://localhost:8080"
          ],
          "response_types": [
            "code"
          ],
          "grant_types": [
            "authorization_code"
          ],
          "application_type": "browser",
          "consent_method": "REQUIRED",
          "issuer_mode": "DYNAMIC",
          "idp_initiated_login": {
            "mode": "DISABLED",
            "default_scope": []
          },
          "wildcard_redirect": "DISABLED",
          "dpop_bound_access_tokens": false
        }
      },
      "_links": {
        "uploadLogo": {
          "href": "https://demo-automation-terraform-12601.okta.com/api/v1/apps/0oazn6qv94X194IGC697/logo",
          "hints": {
            "allow": [
              "POST"
            ]
          }
        },
        "appLinks": [
          {
            "name": "oidc_client_link",
            "href": "https://demo-automation-terraform-12601.okta.com/home/oidc_client/0oazn6qv94X194IGC697/aln177a159h7Zf52X0g8",
            "type": "text/html"
          }
        ],
        "profileEnrollment": {
          "href": "https://demo-automation-terraform-12601.okta.com/api/v1/policies/rstye8z7cc0D7Ft6J697"
        },
        "policies": {
          "href": "https://demo-automation-terraform-12601.okta.com/api/v1/apps/0oazn6qv94X194IGC697/policies",
          "hints": {
            "allow": [
              "PUT"
            ]
          }
        },
        "groups": {
          "href": "https://demo-automation-terraform-12601.okta.com/api/v1/apps/0oazn6qv94X194IGC697/groups"
        },
        "logo": [
          {
            "name": "medium",
            "href": "https://ok14static.oktacdn.com/assets/img/logos/default.6770228fb0dab49a1695ef440a5279bb.png",
            "type": "image/png"
          }
        ],
        "accessPolicy": {
          "href": "https://demo-automation-terraform-12601.okta.com/api/v1/policies/rstzn8c9l8J9gZXh5697"
        },
        "users": {
          "href": "https://demo-automation-terraform-12601.okta.com/api/v1/apps/0oazn6qv94X194IGC697/users"
        },
        "deactivate": {
          "href": "https://demo-automation-terraform-12601.okta.com/api/v1/apps/0oazn6qv94X194IGC697/lifecycle/deactivate"
        }
      }
    },
    "authorization_servers": [
      {
        "server": {
          "id": "auszn8k1qpSPOG9TE697",
          "name": "APP3536352",
          "description": "APP3536352",
          "audiences": [
            "APP3536352"
          ],
          "issuer": "https://demo-automation-terraform-12601.okta.com/oauth2/auszn8k1qpSPOG9TE697",
          "issuerMode": "DYNAMIC",
          "status": "ACTIVE",
          "created": "2026-01-29T15:54:15.000Z",
          "lastUpdated": "2026-01-29T15:54:15.000Z",
          "credentials": {
            "signing": {
              "kid": "7BNkWw0G3ct5G1-YBtvPflJ62HCgkPoXCYoOOop1rs4",
              "rotationMode": "AUTO",
              "lastRotated": "2026-01-29T15:54:15.000Z",
              "nextRotation": "2026-04-29T15:54:15.000Z"
            }
          },
          "default": false,
          "_links": {
            "rotateKey": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8k1qpSPOG9TE697/credentials/lifecycle/keyRotate",
              "hints": {
                "allow": [
                  "POST"
                ]
              }
            },
            "metadata": [
              {
                "name": "oauth-authorization-server",
                "href": "https://demo-automation-terraform-12601.okta.com/oauth2/auszn8k1qpSPOG9TE697/.well-known/oauth-authorization-server",
                "hints": {
                  "allow": [
                    "GET"
                  ]
                }
              },
              {
                "name": "openid-configuration",
                "href": "https://demo-automation-terraform-12601.okta.com/oauth2/auszn8k1qpSPOG9TE697/.well-known/openid-configuration",
                "hints": {
                  "allow": [
                    "GET"
                  ]
                }
              }
            ],
            "resourceServerCredentialsKeys": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8k1qpSPOG9TE697/resourceservercredentials/keys",
              "hints": {
                "allow": [
                  "GET"
                ]
              }
            },
            "keys": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8k1qpSPOG9TE697/credentials/keys",
              "hints": {
                "allow": [
                  "GET"
                ]
              }
            },
            "claims": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8k1qpSPOG9TE697/claims",
              "hints": {
                "allow": [
                  "GET",
                  "POST"
                ]
              }
            },
            "policies": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8k1qpSPOG9TE697/policies",
              "hints": {
                "allow": [
                  "GET",
                  "POST"
                ]
              }
            },
            "self": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8k1qpSPOG9TE697",
              "hints": {
                "allow": [
                  "GET",
                  "DELETE",
                  "PUT"
                ]
              }
            },
            "scopes": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8k1qpSPOG9TE697/scopes",
              "hints": {
                "allow": [
                  "GET",
                  "POST"
                ]
              }
            },
            "deactivate": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8k1qpSPOG9TE697/lifecycle/deactivate",
              "hints": {
                "allow": [
                  "POST"
                ]
              }
            }
          }
        },
        "policy": {
          "id": "00pzn8q8505ENwXTs697",
          "status": "ACTIVE",
          "name": "Standard OIDC Access Policy",
          "description": "Standard OIDC Access Policy",
          "priority": 1,
          "system": false,
          "conditions": {
            "clients": {
              "include": [
                "0oazn6qv94X194IGC697"
              ]
            }
          },
          "created": "2026-01-29T16:01:18.000Z",
          "lastUpdated": "2026-01-29T16:01:18.000Z",
          "_links": {
            "self": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8k1qpSPOG9TE697/policies/00pzn8q8505ENwXTs697",
              "hints": {
                "allow": [
                  "GET",
                  "PUT",
                  "DELETE"
                ]
              }
            },
            "rules": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8k1qpSPOG9TE697/policies/00pzn8q8505ENwXTs697/rules",
              "hints": {
                "allow": [
                  "GET"
                ]
              }
            },
            "deactivate": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8k1qpSPOG9TE697/policies/00pzn8q8505ENwXTs697/lifecycle/deactivate",
              "hints": {
                "allow": [
                  "POST"
                ]
              }
            }
          },
          "type": "OAUTH_AUTHORIZATION_POLICY"
        },
        "rules": [
          {
            "id": "0przn8s7y3teMIfHZ697",
            "status": "ACTIVE",
            "name": "Standard OIDC Access Policy Rule",
            "priority": 1,
            "created": "2026-01-29T16:02:07.000Z",
            "lastUpdated": "2026-01-29T16:02:07.000Z",
            "system": false,
            "conditions": {
              "people": {
                "users": {
                  "include": [],
                  "exclude": []
                },
                "groups": {
                  "include": [
                    "EVERYONE"
                  ],
                  "exclude": []
                }
              },
              "grantTypes": {
                "include": [
                  "client_credentials",
                  "urn:ietf:params:oauth:grant-type:device_code",
                  "authorization_code"
                ]
              },
              "scopes": {
                "include": [
                  "*"
                ]
              }
            },
            "actions": {
              "token": {
                "accessTokenLifetimeMinutes": 60,
                "refreshTokenLifetimeMinutes": 480,
                "refreshTokenWindowMinutes": 480
              }
            },
            "_links": {
              "self": {
                "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8k1qpSPOG9TE697/policies/00pzn8q8505ENwXTs697/rules/0przn8s7y3teMIfHZ697",
                "hints": {
                  "allow": [
                    "GET",
                    "PUT",
                    "DELETE"
                  ]
                }
              },
              "deactivate": {
                "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8k1qpSPOG9TE697/policies/00pzn8q8505ENwXTs697/rules/0przn8s7y3teMIfHZ697/lifecycle/deactivate",
                "hints": {
                  "allow": [
                    "POST"
                  ]
                }
              }
            },
            "type": "RESOURCE_ACCESS"
          }
        ]
      }
    ],
    "source_folder": "spa_type_apps"
  },
  "app3535806-lab-br-tnt-vollmsmobile": {
    "app": {
      "id": "0oazn6smitjmtBwOD697",
      "orn": "orn:okta:idp:00oye8z74hoxMErrs697:apps:oidc_client:0oazn6smitjmtBwOD697",
      "name": "oidc_client",
      "label": "APP3535806-LAB-BR-TNT-VOLLMSMOBILE",
      "status": "ACTIVE",
      "lastUpdated": "2026-01-29T15:15:54.000Z",
      "created": "2026-01-29T15:15:53.000Z",
      "accessibility": {
        "selfService": false,
        "errorRedirectUrl": null,
        "loginRedirectUrl": null
      },
      "visibility": {
        "autoLaunch": false,
        "autoSubmitToolbar": false,
        "hide": {
          "iOS": true,
          "web": true
        },
        "appLinks": {
          "oidc_client_link": true
        }
      },
      "features": [],
      "signOnMode": "OPENID_CONNECT",
      "credentials": {
        "userNameTemplate": {
          "template": "${source.login}",
          "type": "BUILT_IN"
        },
        "signing": {
          "kid": "_SCqUs6pYBOo3ojX3Y79P6O7I8x3Rfit6JpD_7lIG2s"
        },
        "oauthClient": {
          "autoKeyRotation": true,
          "client_id": "0oazn6smitjmtBwOD697",
          "token_endpoint_auth_method": "none",
          "pkce_required": true
        }
      },
      "universalLogout": {
        "status": "DISABLED",
        "supportType": "FULL",
        "identityStack": "NOT_SHARED",
        "protocol": "GLOBAL_TOKEN_REVOCATION"
      },
      "settings": {
        "app": {},
        "notifications": {
          "vpn": {
            "network": {
              "connection": "DISABLED"
            },
            "message": null,
            "helpUrl": null
          }
        },
        "manualProvisioning": false,
        "implicitAssignment": false,
        "emOptInStatus": "NONE",
        "notes": {
          "admin": null,
          "enduser": null
        },
        "oauthClient": {
          "client_uri": null,
          "logo_uri": null,
          "redirect_uris": [
            "com.okta.demo-automation-terraform-12601:/callback"
          ],
          "post_logout_redirect_uris": [
            "com.okta.demo-automation-terraform-12601:/"
          ],
          "response_types": [
            "code"
          ],
          "grant_types": [
            "authorization_code",
            "refresh_token"
          ],
          "application_type": "native",
          "consent_method": "REQUIRED",
          "issuer_mode": "DYNAMIC",
          "refresh_token": {
            "rotation_type": "STATIC"
          },
          "idp_initiated_login": {
            "mode": "DISABLED",
            "default_scope": []
          },
          "wildcard_redirect": "DISABLED",
          "dpop_bound_access_tokens": false
        }
      },
      "_links": {
        "uploadLogo": {
          "href": "https://demo-automation-terraform-12601.okta.com/api/v1/apps/0oazn6smitjmtBwOD697/logo",
          "hints": {
            "allow": [
              "POST"
            ]
          }
        },
        "appLinks": [
          {
            "name": "oidc_client_link",
            "href": "https://demo-automation-terraform-12601.okta.com/home/oidc_client/0oazn6smitjmtBwOD697/aln177a159h7Zf52X0g8",
            "type": "text/html"
          }
        ],
        "profileEnrollment": {
          "href": "https://demo-automation-terraform-12601.okta.com/api/v1/policies/rstye8z7cc0D7Ft6J697"
        },
        "policies": {
          "href": "https://demo-automation-terraform-12601.okta.com/api/v1/apps/0oazn6smitjmtBwOD697/policies",
          "hints": {
            "allow": [
              "PUT"
            ]
          }
        },
        "groups": {
          "href": "https://demo-automation-terraform-12601.okta.com/api/v1/apps/0oazn6smitjmtBwOD697/groups"
        },
        "logo": [
          {
            "name": "medium",
            "href": "https://ok14static.oktacdn.com/assets/img/logos/default.6770228fb0dab49a1695ef440a5279bb.png",
            "type": "image/png"
          }
        ],
        "accessPolicy": {
          "href": "https://demo-automation-terraform-12601.okta.com/api/v1/policies/rstzn8c9l8J9gZXh5697"
        },
        "users": {
          "href": "https://demo-automation-terraform-12601.okta.com/api/v1/apps/0oazn6smitjmtBwOD697/users"
        },
        "deactivate": {
          "href": "https://demo-automation-terraform-12601.okta.com/api/v1/apps/0oazn6smitjmtBwOD697/lifecycle/deactivate"
        }
      }
    },
    "authorization_servers": [
      {
        "server": {
          "id": "auszn8s907u0UQpXV697",
          "name": "APP3535806",
          "description": "APP3535806",
          "audiences": [
            "APP3535806"
          ],
          "issuer": "https://demo-automation-terraform-12601.okta.com/oauth2/auszn8s907u0UQpXV697",
          "issuerMode": "DYNAMIC",
          "status": "ACTIVE",
          "created": "2026-01-29T15:58:49.000Z",
          "lastUpdated": "2026-01-29T15:58:49.000Z",
          "credentials": {
            "signing": {
              "kid": "a2uwfIPQktOH01oZxoyhPSf4MvKqALaQlqFy12uEKwI",
              "rotationMode": "AUTO",
              "lastRotated": "2026-01-29T15:58:49.000Z",
              "nextRotation": "2026-04-29T15:58:49.000Z"
            }
          },
          "default": false,
          "_links": {
            "rotateKey": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8s907u0UQpXV697/credentials/lifecycle/keyRotate",
              "hints": {
                "allow": [
                  "POST"
                ]
              }
            },
            "metadata": [
              {
                "name": "oauth-authorization-server",
                "href": "https://demo-automation-terraform-12601.okta.com/oauth2/auszn8s907u0UQpXV697/.well-known/oauth-authorization-server",
                "hints": {
                  "allow": [
                    "GET"
                  ]
                }
              },
              {
                "name": "openid-configuration",
                "href": "https://demo-automation-terraform-12601.okta.com/oauth2/auszn8s907u0UQpXV697/.well-known/openid-configuration",
                "hints": {
                  "allow": [
                    "GET"
                  ]
                }
              }
            ],
            "resourceServerCredentialsKeys": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8s907u0UQpXV697/resourceservercredentials/keys",
              "hints": {
                "allow": [
                  "GET"
                ]
              }
            },
            "keys": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8s907u0UQpXV697/credentials/keys",
              "hints": {
                "allow": [
                  "GET"
                ]
              }
            },
            "claims": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8s907u0UQpXV697/claims",
              "hints": {
                "allow": [
                  "GET",
                  "POST"
                ]
              }
            },
            "policies": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8s907u0UQpXV697/policies",
              "hints": {
                "allow": [
                  "GET",
                  "POST"
                ]
              }
            },
            "self": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8s907u0UQpXV697",
              "hints": {
                "allow": [
                  "GET",
                  "DELETE",
                  "PUT"
                ]
              }
            },
            "scopes": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8s907u0UQpXV697/scopes",
              "hints": {
                "allow": [
                  "GET",
                  "POST"
                ]
              }
            },
            "deactivate": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8s907u0UQpXV697/lifecycle/deactivate",
              "hints": {
                "allow": [
                  "POST"
                ]
              }
            }
          }
        },
        "policy": {
          "id": "00pzn8schplUGFvHE697",
          "status": "ACTIVE",
          "name": "Standard OIDC Access Policy",
          "description": "Standard OIDC Access Policy",
          "priority": 1,
          "system": false,
          "conditions": {
            "clients": {
              "include": [
                "0oazn6smitjmtBwOD697"
              ]
            }
          },
          "created": "2026-01-29T16:02:42.000Z",
          "lastUpdated": "2026-01-29T16:02:42.000Z",
          "_links": {
            "self": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8s907u0UQpXV697/policies/00pzn8schplUGFvHE697",
              "hints": {
                "allow": [
                  "GET",
                  "PUT",
                  "DELETE"
                ]
              }
            },
            "rules": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8s907u0UQpXV697/policies/00pzn8schplUGFvHE697/rules",
              "hints": {
                "allow": [
                  "GET"
                ]
              }
            },
            "deactivate": {
              "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8s907u0UQpXV697/policies/00pzn8schplUGFvHE697/lifecycle/deactivate",
              "hints": {
                "allow": [
                  "POST"
                ]
              }
            }
          },
          "type": "OAUTH_AUTHORIZATION_POLICY"
        },
        "rules": [
          {
            "id": "0przn918zqekewNxN697",
            "status": "ACTIVE",
            "name": "Standard OIDC Access Policy Rule",
            "priority": 1,
            "created": "2026-01-29T16:03:12.000Z",
            "lastUpdated": "2026-01-29T16:03:12.000Z",
            "system": false,
            "conditions": {
              "people": {
                "users": {
                  "include": [],
                  "exclude": []
                },
                "groups": {
                  "include": [
                    "EVERYONE"
                  ],
                  "exclude": []
                }
              },
              "grantTypes": {
                "include": [
                  "client_credentials",
                  "urn:ietf:params:oauth:grant-type:device_code",
                  "authorization_code"
                ]
              },
              "scopes": {
                "include": [
                  "*"
                ]
              }
            },
            "actions": {
              "token": {
                "accessTokenLifetimeMinutes": 60,
                "refreshTokenLifetimeMinutes": 480,
                "refreshTokenWindowMinutes": 480
              }
            },
            "_links": {
              "self": {
                "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8s907u0UQpXV697/policies/00pzn8schplUGFvHE697/rules/0przn918zqekewNxN697",
                "hints": {
                  "allow": [
                    "GET",
                    "PUT",
                    "DELETE"
                  ]
                }
              },
              "deactivate": {
                "href": "https://demo-automation-terraform-12601.okta.com/api/v1/authorizationServers/auszn8s907u0UQpXV697/policies/00pzn8schplUGFvHE697/rules/0przn918zqekewNxN697/lifecycle/deactivate",
                "hints": {
                  "allow": [
                    "POST"
                  ]
                }
              }
            },
            "type": "RESOURCE_ACCESS"
          }
        ]
      }
    ],
    "source_folder": "native_type_apps"
  }
}
