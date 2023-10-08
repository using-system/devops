data "azurerm_resource_group" "test" {
  name = "tf-test-rg"
}

data "azurerm_client_config" "current" {
}



output "resource_group_name" {
  value = data.azurerm_resource_group.test.name
}

output "resource_group_location" {
  value = data.azurerm_resource_group.test.location
}

output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}

