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
    name                    = "system-az-assigned-identity-identity"
    location                = run.setup.resource_group_location
    resource_group_name     = run.setup.resource_group_name


    tags                    = { Environment = "Test" }
  }

  assert {
    condition      = azurerm_user_assigned_identity.identity.location == var.location
    error_message  = "identity location must be set"
  }

  assert {
    condition      = azurerm_user_assigned_identity.identity.resource_group_name == var.resource_group_name
    error_message  = "identity resource group name must be set"
  }

  assert {
    condition      = azurerm_user_assigned_identity.identity.name == var.name
    error_message  = "identity name must be set"
  }

}

run "apply" {

  command = apply

  variables {
    name                    = "system-az-assigned-identity-identity"
    location                = run.setup.resource_group_location
    resource_group_name     = run.setup.resource_group_name


    tags                    = { Environment = "Test" }
  }

  assert {
    condition      = output.tenant_id == run.setup.tenant_id
    error_message  = "output tenant id must be set"
  }

  assert {
    condition      = output.id != null
    error_message  = "output id must be set"
  }

  assert {
    condition      = output.principal_id != null
    error_message  = "output principal_id must be set"
  }

  assert {
    condition      = output.client_id != null
    error_message  = "output client_id must be set"
  }

}