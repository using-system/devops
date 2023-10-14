output "id" {
  description = "The ID of the Container App Environment"
  value       = azurerm_container_app_environment.acae.id
}

output "static_ip_address" {
  description = "The Static IP address of the Environment"
  value       = azurerm_container_app_environment.acae.static_ip_address
}

