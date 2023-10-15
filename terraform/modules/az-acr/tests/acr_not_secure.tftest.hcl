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
    name                        = "usingsystemazacrtest2"
    location                    = run.setup.resource_group_location
    resource_group_name         = run.setup.resource_group_name

    sku                             = "Standard"
    admin_enabled                   = true
    public_network_access_enabled   = true
    quarantine_policy_enabled       = false
    trust_policy_enabled            = false
    retention_policy_enabled        = false
    enable_lock_on_acr              = false
    network_rule_bypass_option      = "AzureServices"

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
    condition      = azurerm_container_registry.acr.sku == "Standard"
    error_message  = "acr sku must be set to Premium by default"
  }

 assert {
    condition      = azurerm_container_registry.acr.admin_enabled == true
    error_message  = "acr admin_enabled must be set"
  }  

  assert {
    condition      = azurerm_container_registry.acr.quarantine_policy_enabled == false
    error_message  = "acr quarantine_policy_enabled must be set"
  }

  assert {
    condition       = length(azurerm_container_registry.acr.trust_policy) == 1
    error_message  = "acr trust_policy array must contains one element"
  }

  assert {
    condition      = azurerm_container_registry.acr.trust_policy[0].enabled == false
    error_message  = "acr trust_policy.enabled must be set"
  }

  assert {
    condition       = length(azurerm_container_registry.acr.retention_policy) == 1
    error_message  = "acr retention_policy array must contains one element"
  }

  assert {
    condition      = azurerm_container_registry.acr.retention_policy[0].enabled == false
    error_message  = "acr retention_policy.enabled must be set"
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
    condition      = azurerm_container_registry.acr.public_network_access_enabled == true
    error_message  = "acr public_network_access_enabled must be set"
  }

  assert {
    condition      = azurerm_container_registry.acr.network_rule_bypass_option == "AzureServices"
    error_message  = "acr network_rule_bypass_option must be set"
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
    condition       = length(azurerm_management_lock.acr) == 0
    error_message  = "azurerm_management_lock acr must contains be empty"
  }

}

run "apply" {

    command = apply

    variables {
      name                        = "usingsystemazacrtest2"
      location                    = run.setup.resource_group_location
      resource_group_name         = run.setup.resource_group_name

      sku                             = "Standard"
      admin_enabled                   = true
      public_network_access_enabled   = true
      quarantine_policy_enabled       = false
      trust_policy_enabled            = false
      retention_policy_enabled        = false
      enable_lock_on_acr              = false
      network_rule_bypass_option      = "AzureServices"

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
        condition       = output.admin_password != "" && output.admin_password != null
        error_message  = "output admin_password is empty"
    }
}