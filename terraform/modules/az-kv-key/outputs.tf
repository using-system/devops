output "id" {
  description = "The ID of the Key Vault Key."
  value       = azurerm_key_vault_key.key.id
}

output "name" {
  description = "The name of the Key Vault Key."
  value       = var.name
}

output "public_key_pem" {
  description = "The public key of the Key Vault Key in PEM format."
  value       = azurerm_key_vault_key.key.public_key_pem
  sensitive   = true
}

output "public_key_openssh" {
  description = "The public key of the Key Vault Key in OpenSSH format."
  value       = azurerm_key_vault_key.key.public_key_openssh
  sensitive   = true
}
