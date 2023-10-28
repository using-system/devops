provider "azurerm" {
  features {
  }
}

run "setup" {
  module {
    source = "./tests/setup_with_vnet"
  }
}

run "plan" {

  command = plan

  variables {
    name                            = "az-acae-2"
    location                        = run.setup.resource_group_location
    resource_group_name             = run.setup.resource_group_name

    subnet_id                       = run.setup.subnet_id
    internal_load_balancer_enabled  = true
    log_analytics_workspace_id      = run.setup.log_analytics_id

    tags                            = { Environment = "Test" }
  }

  assert {
    condition      = azurerm_container_app_environment.acae.name == var.name
    error_message  = "cae name must be set"
  }

  assert {
    condition      = azurerm_container_app_environment.acae.location == var.location
    error_message  = "cae location must be set"
  }

  assert {
    condition      = azurerm_container_app_environment.acae.resource_group_name == var.resource_group_name
    error_message  = "cae resource_group_name must be set"
  }

  assert {
    condition      = azurerm_container_app_environment.acae.infrastructure_subnet_id == var.subnet_id
    error_message  = "cae infrastructure_subnet_id must be set"
  }

  assert {
    condition      = azurerm_container_app_environment.acae.log_analytics_workspace_id == var.log_analytics_workspace_id
    error_message  = "cae log_analytics_workspace_id must be set"
  }

  assert {
    condition      = azurerm_container_app_environment.acae.internal_load_balancer_enabled == true
    error_message  = "cae internal_load_balancer_enabled must be set to true"
  }

  assert {
    condition       = length(azurerm_container_app_environment.acae.tags) == 1
    error_message  = "cae tags must contains one element"
  }

}


run "apply" {

    command = apply

    variables {
      name                            = "az-acae-2"
      location                        = run.setup.resource_group_location
      resource_group_name             = run.setup.resource_group_name

      subnet_id                       = run.setup.subnet_id
      internal_load_balancer_enabled  = true
      log_analytics_workspace_id      = run.setup.log_analytics_id

      tags                            = { Environment = "Test" }
    }

    assert {
        condition       = output.id != "" && output.id != null
        error_message  = "output id is empty"
    }

    assert {
        condition       = output.static_ip_address != "" && output.static_ip_address != null
        error_message  = "output static_ip_address is empty"
    }
}