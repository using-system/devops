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
    name                            = "az-acae-storage"
    container_app_environment_id    = run.setup.cae_id
    storage_account_name            = run.setup.storage_account_name
    storage_share_name              = run.setup.storage_share_name
    storage_account_access_key      = run.setup.storage_account_access_key
  }

  assert {
    condition      = azurerm_container_app_environment_storage.acae.name == var.name
    error_message  = "cae storage name must be set"
  }

  assert {
    condition      = azurerm_container_app_environment_storage.acae.container_app_environment_id == var.container_app_environment_id
    error_message  = "cae storage container_app_environment_id must be set"
  }

  assert {
    condition      = azurerm_container_app_environment_storage.acae.account_name == var.storage_account_name
    error_message  = "cae storage account_name must be set"
  }

  assert {
    condition      = azurerm_container_app_environment_storage.acae.share_name == var.storage_share_name
    error_message  = "cae storage share_name must be set"
  }

  assert {
    condition      = azurerm_container_app_environment_storage.acae.access_key == var.storage_account_access_key
    error_message  = "cae storage access_key must be set"
  }

  assert {
    condition      = azurerm_container_app_environment_storage.acae.access_mode == "ReadWrite"
    error_message  = "cae storage access_mode must be set to ReadWrite by default"
  }

}


run "apply" {

    command = apply

    variables {
        name                            = "az-acae-storage"
        container_app_environment_id    = run.setup.cae_id
        storage_account_name            = run.setup.storage_account_name
        storage_share_name              = run.setup.storage_share_name
        storage_account_access_key      = run.setup.storage_account_access_key
    }

    assert {
        condition       = output.id != "" && output.id != null
        error_message  = "output id is empty"
    }
}