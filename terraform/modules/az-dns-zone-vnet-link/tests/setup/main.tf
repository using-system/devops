data "azurerm_resource_group" "test" {
  name = "tf-test-rg"
}

resource "azurerm_private_dns_zone" "test" {
  name                = "privatelink.adf.azure.com"
  resource_group_name = data.azurerm_resource_group.test.name

  tags = {
    environment = "Test"
  }
}

resource "azurerm_virtual_network" "test" {
  name                = "system-az-dns-zone-link-vnet"
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

output "resource_group_name" {
  value = data.azurerm_resource_group.test.name
}

output "vnet_id" {
  value = azurerm_virtual_network.test.id
}

output "private_dns_zone_name" {
  value = azurerm_private_dns_zone.test.name
}

