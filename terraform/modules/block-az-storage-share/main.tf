resource "azurerm_storage_share" "storage" {
  name                 = "sharename"
  storage_account_name = var.storage_account_name
  quota                = var.quota
}
