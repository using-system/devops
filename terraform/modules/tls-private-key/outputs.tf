output "id" {
  value = tls_private_key.key.id
}

output "private_key_openssh" {
  value     = tls_private_key.key.private_key_openssh
  sensitive = true
}

output "private_key_pem" {
  value     = tls_private_key.key.private_key_pem
  sensitive = true
}

output "private_key_pem_pkcs8" {
  value     = tls_private_key.key.private_key_pem_pkcs8
  sensitive = true
}

output "public_key_openssh" {
  value     = tls_private_key.key.public_key_openssh
  sensitive = true
}

output "public_key_pem" {
  value     = tls_private_key.key.public_key_pem
  sensitive = true
}
