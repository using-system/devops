data "azurerm_resource_group" "test" {
  name = "tf-test-rg"
}

resource "azurerm_virtual_network" "test" {
  name                = "system-az-kv-vnet"
  location            = data.azurerm_resource_group.test.location
  resource_group_name = data.azurerm_resource_group.test.name
  address_space       = ["10.0.0.0/16"]

  subnet {
    name           = "Subnet1"
    address_prefix = "10.0.0.0/23"
  }

  tags = {
    environment = "Test"
  }
}

data "azurerm_subnet" "test" {

  depends_on = [azurerm_virtual_network.test]

  name                 = "Subnet1"
  virtual_network_name = azurerm_virtual_network.test.name
  resource_group_name  = data.azurerm_resource_group.test.name
}

output "resource_group_name" {
  value = data.azurerm_resource_group.test.name
}

output "resource_group_location" {
  value = data.azurerm_resource_group.test.location
}

output "subnet_id" {
  value = data.azurerm_subnet.test.id
}
