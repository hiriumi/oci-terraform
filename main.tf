terraform {
  required_providers {
    oci = {
      source = "hashicorp/oci"
    }
  }
}

provider "oci" {
  region              = var.region
  config_file_profile = "MY"
}

module "network" {
  source = "./network"
  compartment_id = var.compartment_id
  tenancy_ocid = var.tenancy_ocid
}