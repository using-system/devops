data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "test" {
  name = "tf-test-rg"
}

resource "azurerm_user_assigned_identity" "test" {
  location            = data.azurerm_resource_group.test.location
  name                = "tf-az-storage-identity"
  resource_group_name = data.azurerm_resource_group.test.name
}

output "resource_group_name" {
  value = data.azurerm_resource_group.test.name
}

output "resource_group_location" {
  value = data.azurerm_resource_group.test.location
}

output "identity_id" {
  value = azurerm_user_assigned_identity.test.id
}
