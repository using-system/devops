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
    name                            = "az-aca-hellworld"
    resource_group_name             = run.setup.resource_group_name
    container_app_environment_id    = run.setup.cae_id
    
    tags                            = { Environment = "Test" }
  }

  assert {
    condition      = azurerm_container_app.aca.name == var.name
    error_message  = "aca name must be set"
  }

  assert {
    condition      = azurerm_container_app.aca.container_app_environment_id == var.container_app_environment_id
    error_message  = "aca container_app_environment_id must be set"
  }

  assert {
    condition      = azurerm_container_app.aca.resource_group_name == var.resource_group_name
    error_message  = "aca resource_group_name must be set"
  }

  assert {
    condition      = azurerm_container_app.aca.revision_mode == "Single"
    error_message  = "aca revision_mode must be set to Single by default"
  }

  assert {
    condition      = length(azurerm_container_app.aca.tags) == 1
    error_message  = "aca tags must contains one element"
  }

}

run "apply" {

    command = apply

    variables {
        name                            = "az-aca-hellworld"
        resource_group_name             = run.setup.resource_group_name
        container_app_environment_id    = run.setup.cae_id
    
        tags                            = { Environment = "Test" }
    }

    assert {
        condition       = output.id != "" && output.id != null
        error_message  = "output id is empty"
    }

}