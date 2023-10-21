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

    route_tables = [
    {
      disable_bgp_route_propagation = false
      name                          = "az-routetable-default"
      routes                        = []
    },
    {
      disable_bgp_route_propagation = false
      name                          = "az-routetable-k8s"
      routes = [
      ]
    }
  ]

    tags                    = { Environment = "Test" }
  }

  assert {
    condition       = length(azurerm_route_table.network) == 2
    error_message  = "azurerm_route_table must contains two elements"
  }

  assert {
    condition      = azurerm_route_table.network["az-routetable-default"].name == "az-routetable-default-rt"
    error_message  = "azurerm_route_table default name must be set"
  }

  assert {
    condition      = azurerm_route_table.network["az-routetable-default"].location == var.location
    error_message  = "azurerm_route_table default location must be set"
  }

  assert {
    condition      = azurerm_route_table.network["az-routetable-default"].resource_group_name == var.resource_group_name
    error_message  = "azurerm_route_table default resource_group_name must be set"
  }

  assert {
    condition       = length(azurerm_route_table.network["az-routetable-default"].tags) == 1
    error_message  = "azurerm_route_table default tags must contains one element"
  }

}

run "apply" {

    command = apply
    variables {
        location                = run.setup.resource_group_location
        resource_group_name     = run.setup.resource_group_name

        route_tables = [
    {
      disable_bgp_route_propagation = false
      name                          = "az-routetable-default"
      routes                        = []
    },
    {
      disable_bgp_route_propagation = false
      name                          = "az-routetable-k8s"
      routes = [
      ]
    }
    ]

        tags                    = { Environment = "Test" }
    }
}
