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
    name                        = "usingsystemazacrtest1"
    location                    = run.setup.resource_group_location
    resource_group_name         = run.setup.resource_group_name
    
    tags                        = { Environment = "Test" }
  }

  assert {
    condition      = azurerm_container_registry.acr.name == var.name
    error_message  = "acr name must be set"
  }

  assert {
    condition      = azurerm_container_registry.acr.location == var.location
    error_message  = "acr location must be set"
  }

  assert {
    condition      = azurerm_container_registry.acr.resource_group_name == var.resource_group_name
    error_message  = "acr resource_group_name must be set"
  }

  assert {
    condition      = azurerm_container_registry.acr.sku == "Premium"
    error_message  = "acr sku must be set to Premium by default"
  }

  assert {
    condition      = azurerm_container_registry.acr.admin_enabled == false
    error_message  = "acr admin_enabled must be set to false by default"
  }

  assert {
    condition      = azurerm_container_registry.acr.quarantine_policy_enabled == true
    error_message  = "acr quarantine_policy_enabled must be set to true by default"
  }

  assert {
    condition       = length(azurerm_container_registry.acr.trust_policy) == 1
    error_message  = "acr trust_policy array must contains one element"
  }

  assert {
    condition      = azurerm_container_registry.acr.trust_policy[0].enabled == true
    error_message  = "acr trust_policy.enabled must be set to true by default"
  }

  assert {
    condition       = length(azurerm_container_registry.acr.retention_policy) == 1
    error_message  = "acr retention_policy array must contains one element"
  }

  assert {
    condition      = azurerm_container_registry.acr.retention_policy[0].enabled == true
    error_message  = "acr retention_policy.enabled must be set to true by default"
  }

  assert {
    condition      = azurerm_container_registry.acr.retention_policy[0].days == 7
    error_message  = "acr retention_policy.days must be set to 7 by default"
  }

  assert {
    condition       = length(azurerm_container_registry.acr.identity) == 1
    error_message  = "acr identity array must contains one element"
  }

  assert {
    condition      = azurerm_container_registry.acr.identity[0].type == "SystemAssigned"
    error_message  = "acr identity.type must be set to SystemAssigned by default"
  }

  assert {
    condition      = azurerm_container_registry.acr.public_network_access_enabled == false
    error_message  = "acr public_network_access_enabled must be set to false by default"
  }

  assert {
    condition      = azurerm_container_registry.acr.network_rule_bypass_option == "None"
    error_message  = "acr network_rule_bypass_option must be set to None by default"
  }

  assert {
    condition       = length(azurerm_container_registry.acr.georeplications) == 0
    error_message  = "acr georeplications must be empty"
  }

  assert {
    condition       = length(azurerm_container_registry.acr.tags) == 1
    error_message  = "acr tags must contains one element"
  }

  assert {
    condition       = length(azurerm_management_lock.acr) == 1
    error_message  = "azurerm_management_lock acr must contains one element"
  }

}

run "apply" {

    command = apply

    variables {
        name                        = "usingsystemazacrtest1"
        location                    = run.setup.resource_group_location
        resource_group_name         = run.setup.resource_group_name
    
        tags                        = { Environment = "Test" }
    }

    assert {
        condition       = output.id != "" && output.id != null
        error_message  = "output id is empty"
    }

    assert {
        condition       = output.login_server != "" && output.login_server != null
        error_message  = "output login_server is empty"
    }

    assert {
        condition       = output.admin_password == null || output.admin_password == ""
        error_message  = "output admin_password must be empty"
    }
}