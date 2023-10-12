output "id" {
  description = "The ID of the Windows Virtual Machine"
  value       = azurerm_windows_virtual_machine.vm.id
}

output "admin_username" {
  description = "The admin username of the Windows Virtual Machine"
  value       = var.admin_username
}

output "admin_password" {
  description = "The admin password of the Windows Virtual Machine"
  value       = random_password.vm.result
  sensitive   = true
}
