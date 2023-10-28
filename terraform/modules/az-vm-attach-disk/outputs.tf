output "id" {
  value       = azurerm_virtual_machine_data_disk_attachment.vm.id
  description = "The ID of the Virtual Machine Data Disk attachment."
}

output "disk_id" {
  value       = azurerm_managed_disk.vm.id
  description = "The ID of the disk attached to the Virtual Machine."
}
