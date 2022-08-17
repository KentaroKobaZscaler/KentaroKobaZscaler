# Get Global Access Policy ID
data "zpa_policy_type" "access_policy" {
    policy_type = "ACCESS_POLICY"
}

# Get IdP ID
data "zpa_idp_controller" "idp_name" {
# name = "IdP_Name"
  name = "OKTA"
}

data "zpa_scim_attribute_header" "givenName" {
  name     = "name.givenName"
  idp_name = "OKTA"
}

data "zpa_scim_attribute_header" "familyName" {
  name     = "name.familyName"
  idp_name = "OKTA"
}

#Create Policy Access Rule
resource "zpa_policy_access_rule" "koba-tf-1" {
  name                          = "koba-tf-1"
  description                   = "koba-tf-1"
  action                        = "ALLOW"
  operator                      = "AND"
  policy_set_id                 = data.zpa_policy_type.access_policy.id

  conditions {
    negated   = false
    operator  = "OR"
    operands {
      object_type = "APP"
      lhs = "id"
#      rhs = zpa_application_segment.test_app_segment.id
      rhs = zpa_application_segment.this.id
    }
  }
  conditions {
    negated = false
    operator = "AND"
    operands {
      object_type = "SCIM"
      idp_id      = data.zpa_scim_attribute_header.givenName.idp_id
      lhs         = data.zpa_scim_attribute_header.givenName.id
      rhs         = "Kentaro"
    }
    operands {
      object_type = "SCIM"
      idp_id      = data.zpa_scim_attribute_header.familyName.idp_id
      lhs         = data.zpa_scim_attribute_header.familyName.id
      rhs         = "Koba"
    }
  }
}
