terraform {
  required_providers {
    oci = {
      source = "hashicorp/oci"
    }
  }
}

provider "oci" {
  region              = "us-ashburn-1"
  //auth                = "SecurityToken"
  config_file_profile = "DEFAULT"
}

resource "oci_core_vcn" "ashburn_vcn" {
  dns_label      = "ashburn"
  cidr_block     = "10.0.0.0/16"
  compartment_id = "ocid1.tenancy.oc1..aaaaaaaaca7lntmtszny3mgfhmzb5jb5oi6xucnrb7z6emorxdzheos4m4pa"
  display_name   = "My internal VCN"
}
