output "id" {
  description = "The ID of the Linux Virtual Machine"
  value       = azurerm_linux_virtual_machine.vm.id
}

output "private_ip_address" {
  description = "The private IP address of the Linux Virtual Machine"
  value       = azurerm_network_interface.vm.private_ip_address
}
