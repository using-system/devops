output "vnet_id" {
  description = "Virtual network id"
  value       = azurerm_virtual_network.network.id
}

output "subnet_ids" {
  description = "Subnet ids"
  value       = { for subnet in azurerm_subnet.network : subnet.name => subnet.id }
}
