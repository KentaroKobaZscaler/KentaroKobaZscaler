resource "zia_url_categories" "fin_category" {
  super_category      = "USER_DEFINED"
  configured_name     = "tf fin category"
  description         = "Finance Customcategory by KOBA-TF"
#  keywords            = ["microsoft"]
  custom_category     = true
  type                = "URL_CATEGORY"
  urls = [
    ".888.com",
    ".nationalcasino.com",
    ".hostpapa.com",
  ]
}
#data "zia_url_categories" "corp_category"{
#    id = zia_url_categories.corp_category.id
#}
data "zia_department_management" "fin" {
 name = "Finance {IDP:AAD contoso}"
}

# URL filtering rules
resource "zia_url_filtering_rules" "d_fin_rule" {
    name                = "tf-fin-rule"
    order               = 4
    description         = "Block custom category [fin_category] for Finance"
    state               = "ENABLED"
    action              = "BLOCK"
#    rank                = "5"
    url_categories      = [ zia_url_categories.fin_category.id ]
    protocols           = ["ANY_RULE"]
    request_methods     = [ "CONNECT", "DELETE", "GET", "HEAD", "OPTIONS", "OTHER", "POST", "PUT", "TRACE"]
    // Optional Parameters
    departments {
    id = [data.zia_department_management.fin.id]
  }
}