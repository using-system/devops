data "azurerm_resource_group" "test" {
  name = "tf-test-rg"
}

resource "azurerm_network_security_group" "test" {

  name                = "system-az-vnet-nsg"
  location            = data.azurerm_resource_group.test.location
  resource_group_name = data.azurerm_resource_group.test.name

  security_rule {
    name                       = "AllowAzureBastionInboundHTTPS"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = "*"
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "443"
  }

}

resource "azurerm_route_table" "test" {
  name                          = "system-az-vnet-rt"
  location                      = data.azurerm_resource_group.test.location
  resource_group_name           = data.azurerm_resource_group.test.name
  disable_bgp_route_propagation = false

  route {
    name           = "route1"
    address_prefix = "10.1.0.0/16"
    next_hop_type  = "VnetLocal"
  }

  tags = {
    environment = "Test"
  }
}

output "resource_group_name" {
  value = data.azurerm_resource_group.test.name
}

output "resource_group_location" {
  value = data.azurerm_resource_group.test.location
}

