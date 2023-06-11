output "id" {
  value = azurerm_storage_account.storage.id
}

output "primary_access_key" {
  value     = azurerm_storage_account.storage.primary_access_key
  sensitive = true
}

output "secondary_access_key" {
  value     = azurerm_storage_account.storage.secondary_access_key
  sensitive = true
}
