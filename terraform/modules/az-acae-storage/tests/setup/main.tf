
data "azurerm_resource_group" "test" {
  name = "tf-test-rg"
}

resource "azurerm_container_app_environment" "cae" {
  name                = "az-acae-storage-cae"
  location            = data.azurerm_resource_group.test.location
  resource_group_name = data.azurerm_resource_group.test.name
}

resource "azurerm_storage_account" "cae" {
  name                     = "azacaestorageaccount"
  resource_group_name      = data.azurerm_resource_group.test.name
  location                 = data.azurerm_resource_group.test.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "cae" {
  name                 = "azacaestorageshare"
  storage_account_name = azurerm_storage_account.cae.name
  quota                = 5
}

output "cae_id" {
  value = azurerm_container_app_environment.cae.id
}

output "storage_account_name" {
  value = azurerm_storage_account.cae.name
}

output "storage_account_access_key" {
  value = nonsensitive(azurerm_storage_account.cae.primary_access_key)
}

output "storage_share_name" {
  value = azurerm_storage_share.cae.name
}
