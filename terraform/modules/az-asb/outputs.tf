output "id" {
  description = "The ID of the Service Bus Namespace."
  value       = azurerm_servicebus_namespace.asb.id
}

output "endpoint" {
  description = "The endpoint for the Service Bus Namespace."
  value       = azurerm_servicebus_namespace.asb.endpoint
}
