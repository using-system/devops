data "azurerm_resource_group" "test" {
  name = "tf-test-rg"
}

resource "azurerm_network_security_group" "bastion" {

  name                = "system-az-bastion-nsg"
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

  security_rule {
    name                       = "AllowAzureBastionOutboundSSH"
    priority                   = 200
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = "*"
    source_port_range          = "*"
    destination_address_prefix = "VirtualNetwork"
    destination_port_range     = "22"
  }

  security_rule {
    name                       = "AllowAzureBastionOutboundRDP"
    priority                   = 201
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = "*"
    source_port_range          = "*"
    destination_address_prefix = "VirtualNetwork"
    destination_port_range     = "3389"
  }

  security_rule {
    name                       = "AllowAzureBastionOutboundHTTPS"
    priority                   = 202
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = "*"
    source_port_range          = "*"
    destination_address_prefix = "AzureCloud"
    destination_port_range     = "443"
  }

  security_rule {
    name                       = "AllowAzureBastionOutboundInternet"
    priority                   = 203
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = "*"
    source_port_range          = "*"
    destination_address_prefix = "Internet"
    destination_port_range     = "*"
  }

}

resource "azurerm_virtual_network" "bastion" {
  name                = "system-az-bastion-vnet"
  location            = data.azurerm_resource_group.test.location
  resource_group_name = data.azurerm_resource_group.test.name
  address_space       = ["10.0.0.0/16"]

  subnet {
    name           = "AzureBastionSubnet"
    address_prefix = "10.0.1.0/24"
  }


  tags = {
    environment = "Test"
  }
}

data "azurerm_subnet" "bastion" {

  depends_on = [azurerm_virtual_network.bastion]

  name                 = "AzureBastionSubnet"
  virtual_network_name = azurerm_virtual_network.bastion.name
  resource_group_name  = data.azurerm_resource_group.test.name
}

resource "azurerm_subnet_network_security_group_association" "network" {

  depends_on = [azurerm_virtual_network.bastion]

  subnet_id                 = data.azurerm_subnet.bastion.id
  network_security_group_id = azurerm_network_security_group.bastion.id
}

output "resource_group_name" {
  value = data.azurerm_resource_group.test.name
}

output "resource_group_location" {
  value = data.azurerm_resource_group.test.location
}

output "vnet_name" {
  value = azurerm_virtual_network.bastion.name
}

output "subnet_id" {
  value = data.azurerm_subnet.bastion.id
}
