output "id" {
  description = "Unique identifier for this resource: hexadecimal representation of the SHA1 checksum of the resource"
  value       = tls_private_key.key.id
}

output "private_key_openssh" {
  description = "Private key data in OpenSSH PEM (RFC 4716) format"
  value       = tls_private_key.key.private_key_openssh
  sensitive   = true
}

output "private_key_pem" {
  description = "Private key data in PEM (RFC 1421) format"
  value       = tls_private_key.key.private_key_pem
  sensitive   = true
}

output "private_key_pem_pkcs8" {
  description = "Private key data in PKCS#8 PEM (RFC 5208) format"
  value       = tls_private_key.key.private_key_pem_pkcs8
  sensitive   = true
}

output "public_key_openssh" {
  description = "The public key data in Authorized Keys format"
  value       = tls_private_key.key.public_key_openssh
  sensitive   = true
}

output "public_key_pem" {
  description = "Public key data in PEM (RFC 1421) format"
  value       = tls_private_key.key.public_key_pem
  sensitive   = true
}
