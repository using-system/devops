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
    name                    = "system-az-vnet-tf-module"
    configuration           = {
    address_spaces = ["10.0.0.0/16"]
    subnets = [
      {
        name                                          = "Subnet1"
        address_prefixes                              = ["10.0.0.0/24"]
        service_endpoints                             = []
        private_link_service_network_policies_enabled = true
        private_endpoint_network_policies_enabled     = true
        network_security_group                        = null
        route_table                                   = null
      },
      {
        name                                          = "Subnet2"
        address_prefixes                              = ["10.0.1.0/24"]
        service_endpoints                             = []
        private_link_service_network_policies_enabled = true
        private_endpoint_network_policies_enabled     = true
        network_security_group                        = "system-az-vnet"
        route_table                                   = "system-az-vnet"
      },
      {
        name                                          = "Subnet3"
        address_prefixes                              = ["10.0.2.0/24"]
        service_endpoints                             = []
        private_link_service_network_policies_enabled = true
        private_endpoint_network_policies_enabled     = true
        network_security_group                        = "system-az-vnet"
        route_table                                   = null
      }
    ]
  }

    tags                    = { Environment = "Test" }
  }

  assert {
    condition      = azurerm_virtual_network.network.name == var.name
    error_message  = "azurerm_virtual_network name must be set"
  }

  assert {
    condition      = azurerm_virtual_network.network.location == var.location
    error_message  = "azurerm_virtual_network location must be set"
  }

  assert {
    condition      = azurerm_virtual_network.network.resource_group_name == var.resource_group_name
    error_message  = "azurerm_virtual_network resource_group_name must be set"
  }

  assert {
    condition      = length(azurerm_virtual_network.network.address_space) == 1
    error_message  = "azurerm_virtual_network address_space must contains 1 element"
  }

  assert {
    condition      = azurerm_virtual_network.network.address_space[0] == "10.0.0.0/16"
    error_message  = "azurerm_virtual_network address_space must be set"
  }

  assert {
    condition       = length(azurerm_subnet.network) == 3
    error_message  = "azurerm_subnet network must contains 3 elements"
  }

  assert {
    condition       = length(azurerm_subnet_network_security_group_association.network) == 2
    error_message  = "azurerm_subnet_network_security_group_association network must contains 2 elements"
  }

  assert {
    condition       = length(azurerm_subnet_route_table_association.network) == 1
    error_message  = "azurerm_subnet_network_security_group_association network must contains one element"
  }

  assert {
    condition       = length(azurerm_virtual_network.network.tags) == 1
    error_message  = "azurerm_virtual_network tags must contains one element"
  }

}

run "apply" {

    command = apply

    variables {
        location                = run.setup.resource_group_location
        resource_group_name     = run.setup.resource_group_name
        name                    = "system-az-vnet-tf-module"
        configuration           = {
        address_spaces = ["10.0.0.0/16"]
        subnets = [
        {
            name                                          = "Subnet1"
            address_prefixes                              = ["10.0.0.0/24"]
            service_endpoints                             = []
            private_link_service_network_policies_enabled = true
            private_endpoint_network_policies_enabled     = true
            network_security_group                        = null
            route_table                                   = null
        },
        {
            name                                          = "Subnet2"
            address_prefixes                              = ["10.0.1.0/24"]
            service_endpoints                             = []
            private_link_service_network_policies_enabled = true
            private_endpoint_network_policies_enabled     = true
            network_security_group                        = "system-az-vnet"
            route_table                                   = "system-az-vnet"
        },
        {
            name                                          = "Subnet3"
            address_prefixes                              = ["10.0.2.0/24"]
            service_endpoints                             = []
            private_link_service_network_policies_enabled = true
            private_endpoint_network_policies_enabled     = true
            network_security_group                        = "system-az-vnet"
            route_table                                   = null
        }
        ]
    }

        tags                    = { Environment = "Test" }
    }

    assert {
        condition       = output.vnet_id != "" && output.vnet_id != null
        error_message  = "output vnet_id is empty"
    }

    assert {
        condition       = output.name != "" && output.name != null
        error_message  = "output name is empty"
    }

    assert {
        condition       = length(output.subnet_ids) == 3
        error_message  = "output subnet_ids must contains 3 elements"
    }

    assert {
        condition       = output.subnet_ids["Subnet1"] == azurerm_subnet.network["Subnet1"].id
        error_message  = "output subnet1 id must be set"
    }

    assert {
        condition       = output.subnet_ids["Subnet2"] == azurerm_subnet.network["Subnet2"].id
        error_message  = "output subnet2 id must be set"
    }

    assert {
        condition       = output.subnet_ids["Subnet3"] == azurerm_subnet.network["Subnet3"].id
        error_message  = "output subnet3 id must be set"
    }
}
