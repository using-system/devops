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
    name             = "mykey"
    kv_id            = run.setup.kv_id
    rotation         = {
      auto_rotatation_time_before_expiry = "P30D"
      expire_after                       = "P90D"
      notify_before_expiry               = "P29D"
    }
    tags             = { Environment = "Test" }
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
    condition      = contains(azurerm_key_vault_key.key.key_opts, "decrypt")
    error_message  = "kv key key_opts must contains decrypt"
  }

  assert {
    condition      = contains(azurerm_key_vault_key.key.key_opts, "encrypt")
    error_message  = "kv key key_opts must contains encrypt"
  }

  assert {
    condition      = contains(azurerm_key_vault_key.key.key_opts, "sign")
    error_message  = "kv key key_opts must contains sign"
  }

  assert {
    condition      = contains(azurerm_key_vault_key.key.key_opts, "unwrapKey")
    error_message  = "kv key key_opts must contains unwrapKey"
  }

  assert {
    condition      = contains(azurerm_key_vault_key.key.key_opts, "verify")
    error_message  = "kv key key_opts must contains verify"
  }

  assert {
    condition      = contains(azurerm_key_vault_key.key.key_opts, "wrapKey")
    error_message  = "kv key key_opts must contains wrapKey"
  }

  assert {
    condition      = azurerm_key_vault_key.key.rotation_policy[0].automatic[0].time_before_expiry == var.rotation.auto_rotatation_time_before_expiry
    error_message  = "kv key rotation_policy.automatic.time_before_expiry must be set"
  }

  assert {
    condition      = azurerm_key_vault_key.key.rotation_policy[0].expire_after == var.rotation.expire_after
    error_message  = "kv key rotation_policy.expire_after must be set"
  }

  assert {
    condition      = azurerm_key_vault_key.key.rotation_policy[0].notify_before_expiry == var.rotation.notify_before_expiry
    error_message  = "kv key rotation_policy.notify_before_expiry must be set"
  }

  assert {
    condition      = azurerm_key_vault_key.key.expiration_date == null
    error_message  = "kv key expiration_date must be null"
  }

  assert {
    condition      = length(azurerm_key_vault_key.key.tags) == 1
    error_message  = "kv key tags must be contains one element"
  }

}

run "apply" {

    command = apply

    variables {
    name             = "mykey"
    kv_id            = run.setup.kv_id
    rotation         = {
      auto_rotatation_time_before_expiry = "P30D"
      expire_after                       = "P90D"
      notify_before_expiry               = "P29D"
    }
    tags             = { Environment = "Test" }
  }

    assert {
        condition       = output.id != "" && output.id != null
        error_message  = "output id is empty"
    }

    assert {
        condition       = output.public_key_pem != "" && output.public_key_pem != null
        error_message  = "output public_key_pem is empty"
    }

    assert {
        condition       = output.public_key_openssh != "" && output.public_key_openssh != null
        error_message  = "output public_key_openssh is empty"
    }
}
