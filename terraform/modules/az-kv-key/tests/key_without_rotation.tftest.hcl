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
    name                   = "mykey"
    kv_id                  = run.setup.kv_id
    static_expiration_date = "2035-01-02T15:04:05Z"
    tags                   = { Environment = "Test" }
  }

  assert {
    condition      = azurerm_key_vault_key.key.name == var.name
    error_message  = "kv key name must be set"
  }

  assert {
    condition      = azurerm_key_vault_key.key.key_vault_id == var.kv_id
    error_message  = "kv key key_vault_id must be set"
  }

  assert {
    condition      = azurerm_key_vault_key.key.key_type == "RSA-HSM"
    error_message  = "kv key key_type must be set"
  }

  assert {
    condition      = azurerm_key_vault_key.key.key_size == 4096
    error_message  = "kv key key_size must be set"
  }

  assert {
    condition      = length(azurerm_key_vault_key.key.rotation_policy) == 0
    error_message  = "kv key rotation_policy must be empty"
  }

  assert {
    condition      = azurerm_key_vault_key.key.expiration_date != null
    error_message  = "kv key expiration_date must be set"
  }

  assert {
    condition      = length(azurerm_key_vault_key.key.tags) == 1
    error_message  = "kv key tags must be contains one element"
  }

}