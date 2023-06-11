output "id" {
  description = "The ID of the Key Vault Key."
  value       = azurerm_key_vault_key.cust_managed_key.id
}

output "name" {
  value = var.name
}
