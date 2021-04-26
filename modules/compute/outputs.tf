# Output variables from created compute instance

output "instance_ocid" {
  value = oci_core_instance.compute_instance.id
}
output "public_ip" {
  value = oci_core_instance.compute_instance.public_ip
}

output "generated_private_key_pem" {
  value = var.generate_public_ssh_key ? tls_private_key.compute_ssh_key.private_key_pem : "No Keys Auto Generated"
}
