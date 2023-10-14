
data "azurerm_resource_group" "test" {
  name = "tf-test-rg"
}

resource "azurerm_container_app_environment" "cae" {
  name                = "az-acae-storage-cae"
  location            = data.azurerm_resource_group.test.location
  resource_group_name = data.azurerm_resource_group.test.name
}

output "resource_group_name" {
  value = data.azurerm_resource_group.test.name
}

output "cae_id" {
  value = azurerm_container_app_environment.cae.id
}
