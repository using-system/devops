output "id" {
  description = "The ID of the File Share"
  value       = azurerm_storage_share.storage.id
}

output "name" {
  description = "The name of the File Share"
  value       = var.name
}

output "url" {
  description = "The URL of the File Share"
  value       = azurerm_storage_share.storage.url
}
