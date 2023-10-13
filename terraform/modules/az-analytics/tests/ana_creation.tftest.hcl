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
    name                    = "az-analytics-tf-module"
    configuration           = {
        sku = "PerGB2018"
        retention_in_days = 90
        internet_ingestion_enabled = true
        internet_query_enabled = true
    }

    tags                    = { Environment = "Test" }
  }

  assert {
    condition      = azurerm_log_analytics_workspace.monitoring.name == var.name
    error_message  = "log_analytics name must be set"
  }

  assert {
    condition      = azurerm_log_analytics_workspace.monitoring.location == var.location
    error_message  = "log_analytics location must be set"
  }

  assert {
    condition      = azurerm_log_analytics_workspace.monitoring.resource_group_name == var.resource_group_name
    error_message  = "log_analytics resource group name must be set"
  }

  assert {
    condition      = azurerm_log_analytics_workspace.monitoring.sku == var.configuration.sku
    error_message  = "log_analytics sku must be set"
  }

  assert {
    condition      = azurerm_log_analytics_workspace.monitoring.retention_in_days == var.configuration.retention_in_days
    error_message  = "log_analytics retention_in_days must be set"
  }

  assert {
    condition      = azurerm_log_analytics_workspace.monitoring.internet_ingestion_enabled == var.configuration.internet_ingestion_enabled
    error_message  = "log_analytics internet_ingestion_enabled must be set"
  }

  assert {
    condition      = azurerm_log_analytics_workspace.monitoring.internet_query_enabled == var.configuration.internet_query_enabled
    error_message  = "log_analytics internet_query_enabled must be set"
  }

  assert {
    condition      = length(azurerm_log_analytics_workspace.monitoring.tags) == 1
    error_message  = "log_analytics tags must be set"
  }

}

run "apply" {

    command = apply

    variables {
    location                = run.setup.resource_group_location
    resource_group_name     = run.setup.resource_group_name
    name                    = "az-analytics-tf-module"
    configuration           = {
        sku = "PerGB2018"
        retention_in_days = 90
        internet_ingestion_enabled = true
        internet_query_enabled = true
    }

    tags                    = { Environment = "Test" }
  }

    assert {
        condition       = output.id != "" && output.id != null
        error_message  = "output id is empty"
    }

    assert {
        condition       = output.primary_shared_key != "" && output.primary_shared_key != null
        error_message  = "output primary_shared_key is empty"
    }

    assert {
        condition       = output.secondary_shared_key != "" && output.secondary_shared_key != null
        error_message  = "output secondary_shared_key is empty"
    }

    assert {
        condition       = output.workspace_id != "" && output.workspace_id != null
        error_message  = "output workspace_id is empty"
    }
}