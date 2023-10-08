data "azurerm_resource_group" "test" {
  name = "tf-test-rg"
}

resource "azurerm_virtual_network" "hub" {
  name                = "system-az-vnet-peering-hub-vnet"
  location            = data.azurerm_resource_group.test.location
  resource_group_name = data.azurerm_resource_group.test.name
  address_space       = ["10.0.0.0/16"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
  }

  tags = {
    environment = "Production"
  }
}

resource "azurerm_virtual_network" "spoke" {
  name                = "system-az-vnet-peering-spoke-vnet"
  location            = data.azurerm_resource_group.test.location
  resource_group_name = data.azurerm_resource_group.test.name
  address_space       = ["11.0.0.0/16"]

  subnet {
    name           = "subnet1"
    address_prefix = "11.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "11.0.2.0/24"
  }

  tags = {
    environment = "Production"
  }
}

output "resource_group_name" {
  value = data.azurerm_resource_group.test.name
}

output "hub_vnet_name" {
  value = azurerm_virtual_network.hub.name
}

output "hub_vnet_id" {
  value = azurerm_virtual_network.hub.id
}


output "spoke_vnet_name" {
  value = azurerm_virtual_network.spoke.name
}

output "spoke_vnet_id" {
  value = azurerm_virtual_network.spoke.id
}
