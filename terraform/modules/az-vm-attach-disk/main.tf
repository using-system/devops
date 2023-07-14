
resource "azurerm_key_vault_key" "vm" {
  name         = "${var.name}-key-des"
  key_vault_id = var.disk_encryption_kv_id
  key_type     = "RSA-HSM"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]

  expiration_date = var.encryption_key_expiration_date
}

resource "azurerm_disk_encryption_set" "vm" {
  name                = "${var.name}-des"
  resource_group_name = var.resource_group_name
  location            = var.location
  key_vault_key_id    = azurerm_key_vault_key.vm.id

  identity {
    type         = "UserAssigned"
    identity_ids = var.identity_ids
  }

  tags = var.tags
}

resource "azurerm_managed_disk" "vm" {

  name                 = var.name
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.storage_account_type
  create_option        = var.create_option
  disk_size_gb         = var.disk_size_gb

  public_network_access_enabled = var.public_network_access_enabled
  disk_encryption_set_id        = azurerm_disk_encryption_set.vm.id

  tags = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "vm" {

  depends_on = [azurerm_managed_disk.vm]

  managed_disk_id    = azurerm_managed_disk.vm.id
  virtual_machine_id = var.vm_id
  lun                = var.lun
  caching            = var.caching
}