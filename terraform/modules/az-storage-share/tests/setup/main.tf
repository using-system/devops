data "azurerm_resource_group" "test" {
  name = "tf-test-rg"
}

resource "azurerm_storage_account" "storage" {
  name                     = "systemazstoragesharestr"
  resource_group_name      = data.azurerm_resource_group.test.name
  location                 = data.azurerm_resource_group.test.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}


output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}
