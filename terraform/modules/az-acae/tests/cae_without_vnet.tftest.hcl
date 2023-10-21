provider "azurerm" {
  features {
  }
}

run "setup" {
  module {
    source = "./tests/setup_without_vnet"
  }
}

run "plan" {

  command = plan

  variables {
    name                    = "az-acae-1"
    location                = run.setup.resource_group_location
    resource_group_name     = run.setup.resource_group_name

    tags                    = { Environment = "Test" }
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
    condition      = azurerm_container_app_environment.acae.infrastructure_subnet_id == null
    error_message  = "cae infrastructure_subnet_id must be null"
  }

  assert {
    condition      = azurerm_container_app_environment.acae.log_analytics_workspace_id == null
    error_message  = "cae log_analytics_workspace_id must be null"
  }

  assert {
    condition      = azurerm_container_app_environment.acae.internal_load_balancer_enabled == false
    error_message  = "cae internal_load_balancer_enabled must be set to false by default"
  }

  assert {
    condition       = length(azurerm_container_app_environment.acae.tags) == 1
    error_message  = "cae tags must contains one element"
  }

}