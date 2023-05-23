output "id" {
  value = azurerm_windows_virtual_machine.vm.id
}

output "admin_username" {
  value = var.admin_username
}

output "admin_password" {
  value     = random_password.vm.result
  sensitive = true
}
