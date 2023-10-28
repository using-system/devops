data "azurerm_resource_group" "test" {
  name = "tf-test-rg"
}

resource "azurerm_log_analytics_workspace" "test" {
  name                = "system-az-kv-ana"
  location            = data.azurerm_resource_group.test.location
  resource_group_name = data.azurerm_resource_group.test.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

output "resource_group_name" {
  value = data.azurerm_resource_group.test.name
}

output "resource_group_location" {
  value = data.azurerm_resource_group.test.location
}

output "log_analytics_id" {
  value = azurerm_log_analytics_workspace.test.id
}
