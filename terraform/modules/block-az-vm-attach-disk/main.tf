resource "azurerm_managed_disk" "vm" {

  name                 = var.name
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.storage_account_type
  create_option        = var.create_option
  disk_size_gb         = var.disk_size_gb

  tags = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "vm" {

  depends_on = [azurerm_managed_disk.vm]

  managed_disk_id    = azurerm_managed_disk.vm.id
  virtual_machine_id = var.vm_id
  lun                = var.lun
  caching            = var.caching
}
