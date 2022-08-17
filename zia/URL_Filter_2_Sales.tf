resource "zia_url_categories" "sales_category" {
  super_category      = "USER_DEFINED"
  configured_name     = "tf sales category"
  description         = "Sales Customcategory by KOBA-TF"
#  keywords            = ["microsoft"]
  custom_category     = true
  type                = "URL_CATEGORY"
  urls = [
    ".dailymotion.com",
    ".osiriscomm.com",
    ".level3.com",
  ]
}
#data "zia_url_categories" "corp_category"{
#    id = zia_url_categories.corp_category.id
#}
data "zia_department_management" "sales" {
 name = "Sales {IDP:AAD contoso}"
}

# URL filtering rules
resource "zia_url_filtering_rules" "b_sales_rule" {
    name                = "tf-sales-rule"
    order               = 2
    description         = "Block custom category [sales_category] for sales"
    state               = "ENABLED"
    action              = "BLOCK"
#    rank                = "5"
    url_categories      = [ zia_url_categories.sales_category.id ]
    protocols           = ["ANY_RULE"]
    request_methods     = [ "CONNECT", "DELETE", "GET", "HEAD", "OPTIONS", "OTHER", "POST", "PUT", "TRACE"]
    // Optional Parameters
    departments {
    id = [data.zia_department_management.sales.id]
  }
}