# Output variables from created vcn

output "subnet_ocid" {
  value = oci_core_subnet.public.id
}
