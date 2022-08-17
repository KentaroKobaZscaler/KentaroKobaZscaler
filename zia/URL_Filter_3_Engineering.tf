resource "zia_url_categories" "eng_category" {
  super_category      = "USER_DEFINED"
  configured_name     = "tf eng category"
  description         = "Eng Customcategory by KOBA-TF"
#  keywords            = ["microsoft"]
  custom_category     = true
  type                = "URL_CATEGORY"
  urls = [
    ".Logz.io",
    ".alexa.com",
    ".baidu.com",
  ]
}
#data "zia_url_categories" "corp_category"{
#    id = zia_url_categories.corp_category.id
#}
data "zia_department_management" "eng" {
 name = "Engineering {IDP:AAD contoso}"
}

# URL filtering rules
resource "zia_url_filtering_rules" "c_eng_rule" {
    name                = "tf-eng-rule"
    order               = 3
    description         = "Block custom category [eng_category] for Engineering"
    state               = "ENABLED"
    action              = "BLOCK"
#    rank                = "5"
    url_categories      = [ zia_url_categories.eng_category.id ]
    protocols           = ["ANY_RULE"]
    request_methods     = [ "CONNECT", "DELETE", "GET", "HEAD", "OPTIONS", "OTHER", "POST", "PUT", "TRACE"]
    // Optional Parameters
   departments {
    id = [data.zia_department_management.eng.id]
  }
}