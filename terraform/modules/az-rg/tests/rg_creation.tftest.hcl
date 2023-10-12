provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

variables {
    name     = "system-az-rg-test-rg"
    location = "East US"
    tags     = { Environment = "Test" }
}

run "plan" {

    command = plan

    assert {
        condition   = output.name == "system-az-rg-test-rg"
        error_message  = "Resource group name must be set"
    }

    assert {
        condition   = azurerm_resource_group.rg.location == "eastus"
        error_message  = "location must be set"
    }

    assert {
        condition   = length(azurerm_resource_group.rg.tags) == 1
        error_message  = "Tag must contains 1 entry"
    }
}

run "apply" {

    command = apply

    assert {
        condition       = output.id != "" && output.id != null
        error_message  = "Resource group id is empty"
    }
}