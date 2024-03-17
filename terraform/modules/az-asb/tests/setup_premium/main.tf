data "azurerm_resource_group" "test" {
  name = "tf-test-rg"
}

resource "azurerm_virtual_network" "asb" {
  name                = "system-az-asb-vnet"
  location            = data.azurerm_resource_group.test.location
  resource_group_name = data.azurerm_resource_group.test.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = "Test"
  }
}

resource "azurerm_subnet" "asb" {
  name                 = "ResourcesSubnet"
  resource_group_name  = data.azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.asb.name
  address_prefixes     = ["10.0.0.0/23"]

  service_endpoints = ["Microsoft.ServiceBus"]
}


output "resource_group_name" {
  value = data.azurerm_resource_group.test.name
}

output "resource_group_location" {
  value = data.azurerm_resource_group.test.location
}

output "subnet_id" {
  value = azurerm_subnet.asb.id
}
