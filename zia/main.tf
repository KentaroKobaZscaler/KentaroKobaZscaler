terraform {
  required_providers {
    zia = {
      source = "zscaler/zia"
      version = "2.1.2"
    }
  }
}

provider "zia" {}
