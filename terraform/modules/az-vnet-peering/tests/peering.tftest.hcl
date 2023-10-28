
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
    name                        = "${run.setup.hub_vnet_name}-peering"
    resource_group_name         = run.setup.resource_group_name
    virtual_network_name        = run.setup.hub_vnet_name
    remote_virtual_network_id   = run.setup.spoke_vnet_id
  }

  assert {
    condition      = azurerm_virtual_network_peering.peering.name != "" || azurerm_virtual_network_peering.peering.name != null
    error_message  = "name must be set"
  }

  assert {
    condition      = azurerm_virtual_network_peering.peering.resource_group_name == run.setup.resource_group_name
    error_message  = "resource_group_name must be set"
  }

  assert {
    condition      = azurerm_virtual_network_peering.peering.virtual_network_name == run.setup.hub_vnet_name
    error_message  = "virtual_network_name must be set"
  }

  assert {
    condition      = azurerm_virtual_network_peering.peering.remote_virtual_network_id == run.setup.spoke_vnet_id
    error_message  = "remote_virtual_network_id must be set"
  }

  assert {
    condition      = azurerm_virtual_network_peering.peering.resource_group_name == run.setup.resource_group_name
    error_message  = "resource_group_name must be set"
  }

  assert {
    condition      = azurerm_virtual_network_peering.peering.allow_virtual_network_access
    error_message  = "allow_virtual_network_access must be set to true by default"
  }

  assert {
    condition      = !azurerm_virtual_network_peering.peering.allow_forwarded_traffic
    error_message  = "allow_forwarded_traffic must be set to false by default"
  }

  assert {
    condition      = !azurerm_virtual_network_peering.peering.allow_forwarded_traffic
    error_message  = "allow_forwarded_traffic must be set to false by default"
  }

  assert {
    condition      = !azurerm_virtual_network_peering.peering.use_remote_gateways
    error_message  = "use_remote_gateways must be set to false by default"
  }

}

run "apply" {

    command = apply

    variables {
      name                        = "${run.setup.hub_vnet_name}-peering"
      resource_group_name         = run.setup.resource_group_name
      virtual_network_name        = run.setup.hub_vnet_name
      remote_virtual_network_id   = run.setup.spoke_vnet_id
    }

    assert {
        condition       = output.id != "" && output.id != null
        error_message  = "Peering id is empty"
    }
}