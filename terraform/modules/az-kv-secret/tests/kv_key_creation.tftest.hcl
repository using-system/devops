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
    kv_id            = run.setup.kv_id
    secret_name      = "mysecret"
    secret_value     = "mysecretvalue"
  }


  assert {
    condition      = azurerm_key_vault_secret.keyvault.key_vault_id == var.kv_id
    error_message  = "kv secret key_vault_id must be set"
  }

  assert {
    condition      = azurerm_key_vault_secret.keyvault.name == var.secret_name
    error_message  = "kv secret name must be set"
  }

  assert {
    condition      = azurerm_key_vault_secret.keyvault.content_type == "text/plain"
    error_message  = "kv secret content_type must be set to text/plain by default"
  }

  assert {
    condition      = azurerm_key_vault_secret.keyvault.expiration_date == null
    error_message  = "kv secret content_type must be null by default"
  }

}

run "apply" {

    command = apply

    variables {
        kv_id            = run.setup.kv_id
        secret_name      = "mysecret"
        secret_value     = "mysecretvalue"
    }

    assert {
        condition       = output.id != "" || output.id == null
        error_message  = "output id is empty"
    }
}
