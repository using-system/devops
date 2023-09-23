output "id" {
  value = azurerm_linux_virtual_machine.vm.id
}

output "generated_cluster_private_ssh_key" {
  description = "The generated private ssh key of the linux vm."
  value       = tls_private_key.vm.private_key_pem
  sensitive   = true
}

output "private_ip_address" {
  value = azurerm_network_interface.vm.private_ip_address
}
