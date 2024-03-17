data "azurerm_resource_group" "test" {
  name = "tf-test-rg"
}

resource "azurerm_servicebus_namespace" "test" {
  name                = "system-az-asb-queue"
  location            = data.azurerm_resource_group.test.location
  resource_group_name = data.azurerm_resource_group.test.name
  sku                 = "Standard"

  tags = {
    environment = "Test"
  }
}

output "namespace_id" {
  value = azurerm_servicebus_namespace.test.id
}
