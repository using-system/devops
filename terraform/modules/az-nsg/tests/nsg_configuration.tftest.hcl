provider "azurerm" {
  features {
  }
}

run "setup" {
  module {
    source = "./tests/setup"
  }
}


run "plan" {

  command = plan

  variables {
    location                = run.setup.resource_group_location
    resource_group_name     = run.setup.resource_group_name

    network_security_groups = [
    {
      name = "az-nsg-default"
      rules = [
        {
          name                       = "allow-http"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_address_prefix      = "*"
          source_port_range          = "*"
          destination_address_prefix = "*"
          destination_port_range     = "80"
        }
      ]
    },
    {
      name = "az-nsg-bastion"
      rules = [
        {
          name                       = "AllowAzureBastionInboundHTTPS"
          priority                   = 102
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_address_prefix      = "*"
          source_port_range          = "*"
          destination_address_prefix = "*"
          destination_port_range     = "443"
        },
        {
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
      ]
    }
    ]

    tags                    = { Environment = "Test" }
  }

  assert {
    condition       = length(azurerm_network_security_group.network) == 2
    error_message  = "azurerm_network_security_group must contains two elements"
  }

  assert {
    condition      = azurerm_network_security_group.network["az-nsg-default"].name == "az-nsg-default-nsg"
    error_message  = "azurerm_subnet_nat_gateway_association default name must be set"
  }

  assert {
    condition      = azurerm_network_security_group.network["az-nsg-default"].location == var.location
    error_message  = "azurerm_subnet_nat_gateway_association default location must be set"
  }

  assert {
    condition      = azurerm_network_security_group.network["az-nsg-default"].resource_group_name == var.resource_group_name
    error_message  = "azurerm_subnet_nat_gateway_association default resource_group_name must be set"
  }

  assert {
    condition       = length(azurerm_network_security_group.network["az-nsg-default"].tags) == 1
    error_message  = "azurerm_network_security_group default tags must contains one element"
  }  

  assert {
    condition      = azurerm_network_security_group.network["az-nsg-bastion"].name == "az-nsg-bastion-nsg"
    error_message  = "azurerm_subnet_nat_gateway_association bastion name must be set"
  }

  assert {
    condition      = azurerm_network_security_group.network["az-nsg-bastion"].location == var.location
    error_message  = "azurerm_subnet_nat_gateway_association bastion location must be set"
  }

  assert {
    condition      = azurerm_network_security_group.network["az-nsg-bastion"].resource_group_name == var.resource_group_name
    error_message  = "azurerm_subnet_nat_gateway_association bastion resource_group_name must be set"
  }

  assert {
    condition       = length(azurerm_network_security_group.network["az-nsg-bastion"].tags) == 1
    error_message  = "azurerm_network_security_group bastion tags must contains one element"
  }  

}

run "apply" {

    command = apply

    variables {
      location                = run.setup.resource_group_location
      resource_group_name     = run.setup.resource_group_name

      network_security_groups = [
    {
      name = "default"
      rules = [
        {
          name                       = "allow-http"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_address_prefix      = "*"
          source_port_range          = "*"
          destination_address_prefix = "*"
          destination_port_range     = "80"
        }
      ]
    },
    {
      name = "bastion"
      rules = [
        {
          name                       = "AllowAzureBastionInboundHTTPS"
          priority                   = 102
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_address_prefix      = "*"
          source_port_range          = "*"
          destination_address_prefix = "*"
          destination_port_range     = "443"
        },
        {
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
      ]
    }
    ]

      tags                    = { Environment = "Test" }
    }
}
