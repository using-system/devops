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
    name                                = "system-az-pep"
    location                            = run.setup.resource_group_location
    resource_group_name                 = run.setup.resource_group_name
    subnet_id                           = run.setup.subnet_id
    private_dns_zone_ids                = [ run.setup.private_dns_zone_ids ]
    private_connection_resource_id      = run.setup.storage_account_id
    subresource_names                   = ["blob"]
    tags                                = { Environment = "Test" }
  }


  assert {
    condition      = azurerm_private_endpoint.pep.location == var.location
    error_message  = "pep location must be set"
  }

  assert {
    condition      = azurerm_private_endpoint.pep.resource_group_name == var.resource_group_name
    error_message  = "pep resource group name must be set"
  }

  assert {
    condition      = azurerm_private_endpoint.pep.subnet_id == var.subnet_id
    error_message  = "pep subnet_id must be set"
  }
  
  assert {
    condition       = length(azurerm_private_endpoint.pep.private_dns_zone_group) == 1
    error_message  = "pep private_dns_zone_group must contains one element"
  }

  assert {
    condition       = length(azurerm_private_endpoint.pep.private_dns_zone_group[0].private_dns_zone_ids) == 1
    error_message  = "pep private_dns_zone_ids must contains one element"
  }

  assert {
    condition      = azurerm_private_endpoint.pep.private_dns_zone_group[0].private_dns_zone_ids[0] == var.private_dns_zone_ids[0]
    error_message  = "pep private_dns_zone_ids must be set"
  }

  assert {
    condition       = length(azurerm_private_endpoint.pep.private_service_connection) == 1
    error_message  = "pep private_service_connection must contains one element"
  }

  assert {
    condition      = azurerm_private_endpoint.pep.private_service_connection[0].private_connection_resource_id == var.private_connection_resource_id
    error_message  = "pep private_connection_resource_id must be set"
  }
  
  assert {
    condition       = length(azurerm_private_endpoint.pep.tags) == 1
    error_message  = "pep tags must contains one element"
  }
}

run "apply" {

    command = apply

    variables {
        name                                = "system-az-pep"
        location                            = run.setup.resource_group_location
        resource_group_name                 = run.setup.resource_group_name
        subnet_id                           = run.setup.subnet_id
        private_dns_zone_ids                = [ run.setup.private_dns_zone_ids ]
        private_connection_resource_id      = run.setup.storage_account_id
        subresource_names                   = ["blob"]
        tags                                = { Environment = "Test" }
    }

    assert {
        condition       = output.id != "" && output.id != null
        error_message  = "output id is empty"
    }
}