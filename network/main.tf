resource "oci_core_vcn" "ashburn_vcn" {
  dns_label      = "ashburn"
  cidr_block     = "10.0.0.0/16"
  compartment_id = var.compartment_id
  display_name   = "Ashburn_VCN"
}

resource "oci_core_subnet" "ashburn_public" {
  vcn_id                      = oci_core_vcn.ashburn_vcn.id
  cidr_block                  = "10.0.1.0/24"
  compartment_id              = var.compartment_id
  display_name                = "pub"
  prohibit_public_ip_on_vnic  = false
}


resource "oci_core_subnet" "ashburn_private" {
  vcn_id                      = oci_core_vcn.ashburn_vcn.id
  cidr_block                  = "10.0.2.0/24"
  compartment_id              = var.compartment_id
  display_name                = "pri"
  prohibit_public_ip_on_vnic  = true
}



resource "oci_core_internet_gateway" "ashburn_internet_gateway" {
    #Required
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.ashburn_vcn.id
    display_name = var.internet_gateway_display_name
}


resource "oci_core_route_table" "ashburn_route_table" {
    #Required
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.ashburn_vcn.id

    display_name = "ashburn route table"
}

resource "oci_core_route_table_attachment" "ashburn_route_table_attachment" {
  #Required    
  subnet_id = oci_core_subnet.ashburn.id
  route_table_id =oci_core_route_table.ashburn_route_table.id
}

