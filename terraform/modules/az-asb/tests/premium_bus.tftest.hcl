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
    source = "./tests/setup_premium"
  }
}

run "plan" {

  command = plan

  variables {
    name                            = "azasbpremium"
    location                        = run.setup.resource_group_location
    resource_group_name             = run.setup.resource_group_name

    subnet_ids                      = [run.setup.subnet_id]

    tags                            = { Environment = "Test" }
  }

  assert {
    condition      = azurerm_servicebus_namespace.asb.name == var.name
    error_message  = "azurerm_servicebus_namespace name must be set"
  }

  assert {
    condition      = azurerm_servicebus_namespace.asb.resource_group_name == var.resource_group_name
    error_message  = "azurerm_servicebus_namespace resource_group_name must be set"
  }

  assert {
    condition      = azurerm_servicebus_namespace.asb.location == var.location
    error_message  = "azurerm_servicebus_namespace location must be set"
  }

  assert {
    condition      = azurerm_servicebus_namespace.asb.sku == "Premium"
    error_message  = "azurerm_servicebus_namespace sku must be set to Premium by default"
  }

  assert {
    condition      = azurerm_servicebus_namespace.asb.minimum_tls_version == "1.2"
    error_message  = "azurerm_servicebus_namespace min_tls_version must be set to 1.2"
  }

  assert {
    condition      = azurerm_servicebus_namespace.asb.capacity == 1
    error_message  = "azurerm_servicebus_namespace capacity must be set to 1"
  }

  assert {
    condition      = azurerm_servicebus_namespace.asb.public_network_access_enabled == false
    error_message  = "azurerm_servicebus_namespace public_network_access_enabled must be set to false"
  }

  assert {
    condition      = azurerm_servicebus_namespace.asb.local_auth_enabled == false
    error_message  = "azurerm_servicebus_namespace local_auth_enabled must be set to false"
  }

  assert {
    condition       = length(azurerm_servicebus_namespace.asb.tags) == 1
    error_message  = "azurerm_servicebus_namespace tags must contains one element"
  }
  
}

run "apply" {

    command = apply

    variables {
      name                            = "azasbstandard"
      location                        = run.setup.resource_group_location
      resource_group_name             = run.setup.resource_group_name

      subnet_ids                      = [run.setup.subnet_id]

      tags                            = { Environment = "Test" }
    }

  assert {
    condition       = length(azurerm_servicebus_namespace.asb.network_rule_set) == 1
    error_message  = "acazurerm_servicebus_namespacer network_rule_set array must contains 1 element"
  }

  assert {
    condition       = length(azurerm_servicebus_namespace.asb.identity) == 0
    error_message  = "acazurerm_servicebus_namespacer identity array must contains 0 element"
  }

  assert {
    condition       = length(azurerm_servicebus_namespace.asb.customer_managed_key) == 0
    error_message  = "acazurerm_servicebus_namespacer customer_managed_key array must contains 0 element"
  }

  assert {
      condition       = output.id != "" && output.id != null
      error_message  = "output id is empty"
  }

  assert {
      condition       = output.endpoint != "" && output.endpoint != null
      error_message  = "output endpoint is empty"
  }
}