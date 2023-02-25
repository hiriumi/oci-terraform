resource "oci_core_vcn" "ashburn_vcn" {
  dns_label      = "ashburn"
  cidr_block     = "10.0.0.0/16"
  compartment_id = var.compartment_id
  display_name   = "ashburn_VCN"
}

resource "oci_core_subnet" "ashburn_public" {
  vcn_id                      = oci_core_vcn.ashburn_vcn.id
  cidr_block                  = "10.0.1.0/24"
  compartment_id              = var.compartment_id
  display_name                = "pub"
  prohibit_public_ip_on_vnic  = false
  prohibit_internet_ingress = false
  dns_label = "sub"
}

resource "oci_core_subnet" "ashburn_private" {
    vcn_id                      = oci_core_vcn.ashburn_vcn.id
    cidr_block                  = "10.0.2.0/24"
    compartment_id              = var.compartment_id
    display_name                = "pri"
    prohibit_public_ip_on_vnic  = true
    prohibit_internet_ingress = true
}

resource "oci_core_internet_gateway" "ashburn_internet_gateway" {
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.ashburn_vcn.id
    display_name = var.internet_gateway_display_name
}

resource "oci_core_default_route_table" "this" {
  manage_default_resource_id = oci_core_subnet.ashburn_public.route_table_id
  route_rules {
    network_entity_id = oci_core_internet_gateway.ashburn_internet_gateway.id
    destination = "0.0.0.0/0"
  }
}

resource "oci_core_nat_gateway" "ashburn_nat_gateway" {
    #Required
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.ashburn_vcn.id
    display_name = "ashburn NAT gateway"
}

