resource "zia_url_categories" "koba_category" {
  super_category      = "USER_DEFINED"
  configured_name     = "tf koba category"
  description         = "Customcategory by KOBA-TF"
#  keywords            = ["microsoft"]
  custom_category     = true
  type                = "URL_CATEGORY"
  urls = [
    ".yahoo.co.jp",
     ".uefa.com",
     ".cnn.com",
  ]
}

data "zia_department_management" "koba" {
 name = "Kentaro Koba, home"
}

# URL filtering rules
resource "zia_url_filtering_rules" "a_koba_rule" {
    name                = "tf-koba-rule"
    order               = 1
    description         = "Block custom category [tf koba category] for Kentaro Koba"
    state               = "ENABLED"
    action              = "BLOCK"
#    rank                = "1"
    url_categories      = [ zia_url_categories.koba_category.id ]
    protocols           = ["ANY_RULE"]
    request_methods     = [ "CONNECT", "DELETE", "GET", "HEAD", "OPTIONS", "OTHER", "POST", "PUT", "TRACE"]
    // Optional Parameters
    departments {
    id = [data.zia_department_management.koba.id]
  }
}