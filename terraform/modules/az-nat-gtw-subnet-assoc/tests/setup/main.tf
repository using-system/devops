data "azurerm_resource_group" "test" {
  name = "tf-test-rg"
}

resource "azurerm_virtual_network" "test" {
  name                = "tf-az-nat-gtw-assoc-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.test.location
  resource_group_name = data.azurerm_resource_group.test.name
}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = data.azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.test.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "subnet2" {
  name                 = "subnet2"
  resource_group_name  = data.azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.test.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_nat_gateway" "test" {
  name                = "tf-az-nat-gtw-assoc-gtw"
  location            = data.azurerm_resource_group.test.location
  resource_group_name = data.azurerm_resource_group.test.name
}

output "subnet_ids" {
  value = [azurerm_subnet.subnet1.id, azurerm_subnet.subnet2.id]
}

output "nat_gateway_id" {
  value = azurerm_nat_gateway.test.id
}
