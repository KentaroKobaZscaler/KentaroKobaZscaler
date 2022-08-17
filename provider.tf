terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    zpa = {
      source  = "zscaler/zpa"
      #      version = "2.1.1"
    }
  }
  required_version = ">= 0.13"
}

# Configure AWS Provider
provider "aws" {
  region = var.aws-region
}

# Configure the ZPA Provider
provider "zpa" {}
