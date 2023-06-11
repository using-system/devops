resource "azurerm_storage_share" "storage" {
  name                 = var.name
  storage_account_name = var.storage_account_name
  quota                = var.quota
}
