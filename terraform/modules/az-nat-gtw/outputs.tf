output "id" {
  description = "The nat gateway ID."
  value       = azurerm_nat_gateway.nat_gtw.id
}

output "resource_guid" {
  description = "The resource guid of the nat gateway."
  value       = azurerm_nat_gateway.nat_gtw.resource_guid
}
