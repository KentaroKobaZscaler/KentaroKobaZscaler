resource "zia_url_categories" "corp_category" {
  super_category      = "USER_DEFINED"
  configured_name     = "tf corp category"
  description         = "Corp Customcategory by KOBA-TF"
#  keywords            = ["microsoft"]
  custom_category     = true
  type                = "URL_CATEGORY"
  urls = [
    ".coupons.com",
    ".resource.alaskaair.net",
    ".techrepublic.com",
  ]
}
#data "zia_url_categories" "corp_category"{
#    id = zia_url_categories.corp_category.id
#}
#data "zia_department_management" "corp" {
# name = "Kentaro Koba, home"
#}

# URL filtering rules
resource "zia_url_filtering_rules" "e_corp_rule" {
    name                = "tf-corp-rule"
    order               = 5
    description         = "Block custom category [corp_category] for all employees"
    state               = "ENABLED"
    action              = "BLOCK"
#    rank                = "5"
    url_categories      = [ zia_url_categories.corp_category.id ]
    protocols           = ["ANY_RULE"]
    request_methods     = [ "CONNECT", "DELETE", "GET", "HEAD", "OPTIONS", "OTHER", "POST", "PUT", "TRACE"]
    // Optional Parameters
#    departments {
#    id = [data.zia_department_management.koba.id]
#  }
}