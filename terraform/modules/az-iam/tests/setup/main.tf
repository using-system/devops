data "azurerm_client_config" "current" {
}

data "azurerm_resource_group" "test" {
  name = "tf-test-rg"
}

output "scope" {
  value = data.azurerm_resource_group.test.id
}

output "principal_id" {
  value = data.azurerm_client_config.current.object_id
}
