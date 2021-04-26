
output "generated_private_key_pem" {
  value = module.compute.generated_private_key_pem
}

output "sonarQube_public_url" {
  value = format("http://%s:9000", module.compute.public_ip)
}
