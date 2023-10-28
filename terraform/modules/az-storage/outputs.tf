output "id" {
  description = "The ID of the Storage Account"
  value       = azurerm_storage_account.storage.id
}

output "name" {
  description = "The name of the Storage Account"
  value       = var.name

}

output "primary_access_key" {
  description = "The primary access key for the storage account"
  value       = azurerm_storage_account.storage.primary_access_key
  sensitive   = true
}

output "secondary_access_key" {
  description = "The secondary access key for the storage account"
  value       = azurerm_storage_account.storage.secondary_access_key
  sensitive   = true
}

output "principal_id" {
  description = "The Principal ID for the Service Principal associated with the Identity of this Storage Account"
  value       = azurerm_storage_account.storage.identity[0].principal_id
}

output "tenant_id" {
  description = "The Tenant ID for the Service Principal associated with the Identity of this Storage Account"
  value       = azurerm_storage_account.storage.identity[0].tenant_id
}
