# Create VCN

resource "oci_core_virtual_network" "sonarvcn" {
  cidr_block     = "10.0.0.0/16"
  compartment_id = var.compartment_ocid
  display_name   = "vcn"
}

# Create internet gateway to allow public internet traffic

resource "oci_core_internet_gateway" "internet_gateway" {
  compartment_id = var.compartment_ocid
  display_name   = "internet_gateway"
  vcn_id         = oci_core_virtual_network.sonarvcn.id
}

# Create route table to connect vcn to internet gateway

resource "oci_core_route_table" "public_route_table" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.sonarvcn.id
  display_name   = "RouteTable"
  route_rules {
    cidr_block        = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.internet_gateway.id
  }
}

# Create security list to allow internet access from compute and ssh access

resource "oci_core_security_list" "public_security_list" {
  compartment_id = var.compartment_ocid
  display_name   = "SecurityList"
  vcn_id         = oci_core_virtual_network.sonarvcn.id
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"
  }
  ingress_security_rules {
    protocol  = "6" // tcp
    source    = "0.0.0.0/0"
    stateless = false

    tcp_options {
      min = 22
      max = 22
    }
  }
  ingress_security_rules {
    protocol  = "6" // tcp
    source    = "0.0.0.0/0"
    stateless = false

    tcp_options {
      min = 9000
      max = 9000
    }
  }
}

# Create subnet in vcn

resource "oci_core_subnet" "public" {
  cidr_block        = "10.0.1.0/24"
  display_name      = "sonar_public_subnet"
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_virtual_network.sonarvcn.id
  dhcp_options_id   = oci_core_virtual_network.sonarvcn.default_dhcp_options_id
  route_table_id    = oci_core_route_table.public_route_table.id
  security_list_ids = [oci_core_security_list.public_security_list.id]
}
