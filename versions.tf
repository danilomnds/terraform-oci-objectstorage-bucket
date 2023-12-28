terraform {
  required_version = ">= 1.6.6"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "5.23.0"
    }
  }
}