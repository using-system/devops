provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = false
      recover_soft_deleted_key_vaults = true
    }
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
    name                        = "az-kv-tfmodule-test-2"
    resource_group_name         = run.setup.resource_group_name
    location                    = run.setup.resource_group_location

    log_analytics_workspace_id  = run.setup.log_analytics_id
    network_subnet_ids          = [ run.setup.subnet_id ]

    tags                        = { Environment = "Test" }
  }

  assert {
    condition      = azurerm_key_vault.keyvault.name == var.name
    error_message  = "kv name must be set"
  }

  assert {
    condition      = azurerm_key_vault.keyvault.location == var.location
    error_message  = "kv location must be set"
  }

  assert {
    condition      = azurerm_key_vault.keyvault.resource_group_name == var.resource_group_name
    error_message  = "kv resource_group_name must be set"
  }

  assert {
    condition      = azurerm_key_vault.keyvault.tenant_id != null
    error_message  = "kv tenant_id must be set"
  }

  assert {
    condition      = azurerm_key_vault.keyvault.sku_name == "standard"
    error_message  = "kv sku_name must be set to sku_name by default"
  }

  assert {
    condition      = azurerm_key_vault.keyvault.enable_rbac_authorization == true
    error_message  = "kv enable_rbac_authorization must be set to true by default"
  }

  assert {
    condition      = azurerm_key_vault.keyvault.soft_delete_retention_days == 7
    error_message  = "kv soft_delete_retention_days must be set to 7 by default"
  }

  assert {
    condition      = azurerm_key_vault.keyvault.purge_protection_enabled == true
    error_message  = "kv purge_protection_enabled must be set to true by default"
  }

  assert {
    condition      = azurerm_key_vault.keyvault.network_acls[0].bypass == "AzureServices"
    error_message  = "kv network_acls.bypass must be set to AzureServices by default"
  }

  assert {
    condition      = azurerm_key_vault.keyvault.network_acls[0].default_action == "Allow"
    error_message  = "kv network_acls.default_action must be set to Allow by default"
  }

  assert {
    condition      = length(azurerm_key_vault.keyvault.network_acls[0].virtual_network_subnet_ids) == 1
    error_message  = "kv network_acls.virtual_network_subnet_ids must contains 1 element"
  }

  assert {
    condition      = contains(azurerm_key_vault.keyvault.network_acls[0].virtual_network_subnet_ids, var.network_subnet_ids[0])
    error_message  = "kv subnet_id must be set"
  }

  assert {
    condition      = azurerm_key_vault.keyvault.public_network_access_enabled == false
    error_message  = "kv public_network_access_enabled must be set to false by default"
  }

  assert {
    condition       = length(azurerm_key_vault.keyvault.tags) == 1
    error_message  = "dns zone link tags must contains one element"
  }

  assert {
    condition      = azurerm_monitor_diagnostic_setting.keyvault.name == "keyvault-logging"
    error_message  = "azurerm_monitor_diagnostic_setting name must be set"
  }

  assert {
    condition      = azurerm_monitor_diagnostic_setting.keyvault.log_analytics_workspace_id == var.log_analytics_workspace_id
    error_message  = "azurerm_monitor_diagnostic_setting log_analytics_workspace_id must be set"
  }
}

run "apply" {

    command = apply

    variables {
        name                        = "az-kv-tfmodule-test"
        resource_group_name         = run.setup.resource_group_name
        location                    = run.setup.resource_group_location

        log_analytics_workspace_id  = run.setup.log_analytics_id
        network_subnet_ids          = [ run.setup.subnet_id ]

        tags                        = { Environment = "Test" }
    }


    assert {
        condition       = output.id != "" && output.id != null
        error_message  = "output id is empty"
    }

    assert {
        condition       = output.uri != "" && output.uri != null
        error_message  = "output uri is empty"
    }
}