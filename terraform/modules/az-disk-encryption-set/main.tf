resource "azurerm_disk_encryption_set" "encryption_set" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  key_vault_key_id    = var.kv_key_id_cust_managed_key

  identity {
    type         = "UserAssigned"
    identity_ids = var.identity_ids
  }

  tags = var.tags
}
