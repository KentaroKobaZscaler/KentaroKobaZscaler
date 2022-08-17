# ZPA Application Segment resource
resource "zpa_application_segment" "this" {
    name              = "koba-tf-1"
    description       = "koba-tf-1"
    enabled           = true
    health_reporting  = "ON_ACCESS"
    bypass_type       = "NEVER"
    is_cname_enabled  = true
    tcp_port_ranges   = ["80", "443"]
    domain_names      = [
        "server.koba-tf.com",
        "*.browserleaks.com"
    ]
    segment_group_id  = zpa_segment_group.this.id
    server_groups {
        id = [ zpa_server_group.this.id]
    }
    depends_on = [ zpa_server_group.this, zpa_segment_group.this]
}

# ZPA Segment Group resource
resource "zpa_segment_group" "this" {
  name            = "koba-tf-1"
  description     = "koba-tf-1"
  enabled         = true
}

# ZPA Server Group resource
resource "zpa_server_group" "this" {
  name              = "koba-tf-1"
  description       = "koba-tf-1"
  enabled           = true
  dynamic_discovery = true
  app_connector_groups {
    id = [ zpa_app_connector_group.aws_connector_group.id ]
  }
  depends_on = [ zpa_app_connector_group.aws_connector_group ]
}
