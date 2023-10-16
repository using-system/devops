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
    name                    = "az-dns-zone-vnet-link"
    resource_group_name     = run.setup.resource_group_name

    private_dns_zone_name   = run.setup.private_dns_zone_name
    vnet_id                 = run.setup.vnet_id

    tags                    = { Environment = "Test" }
  }

  assert {
    condition      = azurerm_private_dns_zone_virtual_network_link.dns.name == var.name
    error_message  = "dns zone link name must be set"
  }

  assert {
    condition      = azurerm_private_dns_zone_virtual_network_link.dns.resource_group_name == var.resource_group_name
    error_message  = "dns zone link resource_group_name must be set"
  }

  assert {
    condition      = azurerm_private_dns_zone_virtual_network_link.dns.private_dns_zone_name == var.private_dns_zone_name
    error_message  = "dns zone link private_dns_zone_name must be set"
  }

  assert {
    condition      = azurerm_private_dns_zone_virtual_network_link.dns.virtual_network_id == var.vnet_id
    error_message  = "dns zone link virtual_network_id must be set"
  }

  assert {
    condition      = azurerm_private_dns_zone_virtual_network_link.dns.registration_enabled == false
    error_message  = "dns zone link registration_enabled must be set to false by default"
  }

  assert {
    condition       = length(azurerm_private_dns_zone_virtual_network_link.dns.tags) == 1
    error_message  = "dns zone link tags must contains one element"
  }
}

run "apply" {

    command = apply

    variables {
        name                    = "az-dns-zone-vnet-link"
        resource_group_name     = run.setup.resource_group_name

        private_dns_zone_name   = run.setup.private_dns_zone_name
        vnet_id                 = run.setup.vnet_id

        tags                    = { Environment = "Test" }
    }


    assert {
        condition       = output.id != "" && output.id != null
        error_message  = "output id is empty"
    }
}