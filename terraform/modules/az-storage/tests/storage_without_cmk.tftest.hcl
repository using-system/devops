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
    source = "./tests/setup"
  }
}

run "plan" {

  command = plan

  variables {
    name                    = "azstoragewithoutcmk"
    location                = run.setup.resource_group_location
    resource_group_name     = run.setup.resource_group_name

    identity_type           = "UserAssigned"
    identity_ids            = [run.setup.identity_id]

    tags                    = { Environment = "Test" }
  }

  assert {
    condition      = azurerm_storage_account.storage.name == var.name
    error_message  = "azurerm_storage_account name must be set"
  }

  assert {
    condition      = azurerm_storage_account.storage.resource_group_name == var.resource_group_name
    error_message  = "azurerm_storage_account resource_group_name must be set"
  }

  assert {
    condition      = azurerm_storage_account.storage.location == var.location
    error_message  = "azurerm_storage_account location must be set"
  }

  assert {
    condition      = azurerm_storage_account.storage.account_tier == "Standard"
    error_message  = "azurerm_storage_account account_tier must be set to Standard by default"
  }

  assert {
    condition      = azurerm_storage_account.storage.min_tls_version == "TLS1_2"
    error_message  = "azurerm_storage_account min_tls_version must be set to TLS1_2 by default"
  }

  assert {
    condition      = azurerm_storage_account.storage.shared_access_key_enabled == true
    error_message  = "azurerm_storage_account shared_access_key_enabled must be set to true by default"
  }

  assert {
    condition      = azurerm_storage_account.storage.public_network_access_enabled == false
    error_message  = "azurerm_storage_account public_network_access_enabled must be set to false by default"
  }

  assert {
    condition      = azurerm_storage_account.storage.allow_nested_items_to_be_public == false
    error_message  = "azurerm_storage_account allow_nested_items_to_be_public must be set to false by default"
  }

  assert {
    condition      = azurerm_storage_account.storage.network_rules[0].default_action == "Deny"
    error_message  = "azurerm_storage_account network_rules.default_action must be set to Deny by default"
  }

  assert {
    condition      = azurerm_storage_account.storage.network_rules[0].bypass == toset(["AzureServices"])
    error_message  = "azurerm_storage_account network_rules.bypass must be set to AzureServices by default"
  }

  assert {
    condition      = azurerm_storage_account.storage.identity[0].type == var.identity_type
    error_message  = "azurerm_storage_account identity.type must be set"
  }

  assert {
    condition      = azurerm_storage_account.storage.identity[0].identity_ids == toset(var.identity_ids)
    error_message  = "azurerm_storage_account identity.identity_ids must be set"
  }

  assert {
    condition       = length(azurerm_storage_account.storage.tags) == 1
    error_message  = "azurerm_storage_account tags must contains one element"
  }

  assert {
    condition       = length(azurerm_storage_account_customer_managed_key.storage) == 0
    error_message  = "azurerm_storage_account_customer_managed_key storage must be empty"
  }
  
}

run "apply" {

    command = apply

    variables {
      name                    = "azstoragewithoutcmk"
      location                = run.setup.resource_group_location
      resource_group_name     = run.setup.resource_group_name

      identity_type           = "UserAssigned"
      identity_ids            = [run.setup.identity_id]

      tags                    = { Environment = "Test" }
    }

    assert {
        condition       = output.id != "" && output.id != null
        error_message  = "output id is empty"
    }

    assert {
        condition       = output.name == var.name
        error_message  = "output name must be set"
    }

    assert {
        condition       = output.primary_access_key != "" && output.primary_access_key != null
        error_message  = "output primary_access_key is empty"
    }

    assert {
        condition       = output.secondary_access_key != "" && output.secondary_access_key != null
        error_message  = "output secondary_access_key is empty"
    }
}