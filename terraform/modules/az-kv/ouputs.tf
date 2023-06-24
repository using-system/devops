output "id" {
  description = "The ID of the created Azure Key Vault."
  value       = azurerm_key_vault.keyvault.id
}

output "uri" {
  description = "The URI of the created Azure Key Vault."
  value       = azurerm_key_vault.keyvault.vault_uri
}
