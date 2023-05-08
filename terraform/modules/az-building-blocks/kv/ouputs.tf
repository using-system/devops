output "keyvault_id" {
  description = "The ID of the created Azure Key Vault."
  value       = azurerm_key_vault.keyvault.id
}

output "keyvault_uri" {
  description = "The URI of the created Azure Key Vault."
  value       = azurerm_key_vault.keyvault.vault_uri
}