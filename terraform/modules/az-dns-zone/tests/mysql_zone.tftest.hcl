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
    name                    = "privatelink.mysql.database.azure.com"
    resource_group_name     = run.setup.resource_group_name

    tags                    = { Environment = "Test" }
  }

  assert {
    condition      = azurerm_private_dns_zone.dns.name == var.name
    error_message  = "dns zone name must be set"
  }

  assert {
    condition      = azurerm_private_dns_zone.dns.resource_group_name == var.resource_group_name
    error_message  = "dns zone resource_group_name must be set"
  }
  assert {
    condition       = length(azurerm_private_dns_zone.dns.tags) == 1
    error_message  = "dns zone tags must contains one element"
  }
}

run "apply" {

    command = apply

    variables {
        name                    = "privatelink.mysql.database.azure.com"
        resource_group_name     = run.setup.resource_group_name

        tags                    = { Environment = "Test" }
    }


    assert {
        condition       = output.id != "" && output.id != null
        error_message  = "output id is empty"
    }
}