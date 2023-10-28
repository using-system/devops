
data "azurerm_resource_group" "test" {
  name = "tf-test-rg"
}

output "resource_group_name" {
  value = data.azurerm_resource_group.test.name
}

output "resource_group_location" {
  value = data.azurerm_resource_group.test.location
}
