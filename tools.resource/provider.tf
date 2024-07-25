# Terraform Provider
terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 6.1.0"
    }
  }
  required_version = ">= 1.2.0"
}

# https://docs.oracle.com/en-us/iaas/Content/ResourceManager/Concepts/terraformconfigresourcemanager.htm
provider "oci" {
  region = "ap-tokyo-1"
}
