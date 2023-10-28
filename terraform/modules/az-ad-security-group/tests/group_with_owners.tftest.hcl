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
    name       = "az-ad-security-group-1"
    owners     = [ run.setup.app_object_id ]
  }

  assert {
    condition      = azuread_group.aad_group.display_name == var.name
    error_message  = "group name must be set"
  }

  assert {
    condition      = length(azuread_group.aad_group.owners) == 1 && contains(azuread_group.aad_group.owners, var.owners[0])
    error_message  = "group owners must be set"
  }

  assert {
    condition      = azuread_group.aad_group.security_enabled == true
    error_message  = "group security_enabled must be set to true"
  }

}

run "apply" {

    command = apply

    variables {
        name       = "az-ad-security-group"
        owners     = [ run.setup.app_object_id ]
    }

    assert {
        condition       = output.object_id != "" && output.object_id != null
        error_message  = "output object_id is empty"
    }
}