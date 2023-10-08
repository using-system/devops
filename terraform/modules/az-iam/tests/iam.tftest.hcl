
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
    scope         = run.setup.scope
    role_name     = "Contributor"
    principal_id  = run.setup.principal_id
  }

  assert {
    condition      = azurerm_role_assignment.iam.scope == var.scope
    error_message  = "Scope iam must be equals to scope variable"
  }

  assert {
    condition      = azurerm_role_assignment.iam.role_definition_name == var.role_name
    error_message  = "Role definition name must be equals to role_name variable"
  }

  assert {
    condition      = azurerm_role_assignment.iam.principal_id == run.setup.principal_id
    error_message  = "Principal id name must be equals to current principal id"
  }

}

run "apply" {
  command = apply

  variables {
    scope         = run.setup.scope
    role_name     = "Contributor"
    principal_id  = run.setup.principal_id
  }

  assert {
    condition      = output.id != "" 
    error_message  = "IAM ID is empty"
  }

  assert {
    condition      = output.principal_type == "Application" || output.principal_type == "User"
    error_message  = "Output principal type must be an application registration or user"
  }
}