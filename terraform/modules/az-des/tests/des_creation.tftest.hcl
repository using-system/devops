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
    location                = run.setup.resource_group_location
    resource_group_name     = run.setup.resource_group_name
    name                    = "usingsystem-az-des-test"
    kv_id                   = run.setup.kv_id
    identity_id             = run.setup.identity_id
    principal_id            = run.setup.principal_id

    tags                    = { Environment = "Test" }
  }


  assert {
    condition      = azurerm_key_vault_key.des.name == var.name
    error_message  = "keyvault key name must be set"
  }

  assert {
    condition      = azurerm_key_vault_key.des.key_vault_id == var.kv_id
    error_message  = "keyvault key key_vault_id must be set"
  }

  assert {
    condition      = azurerm_key_vault_key.des.key_type == "RSA-HSM"
    error_message  = "keyvault key key_type must be set to RSA-HSM"
  }

  assert {
    condition      = azurerm_key_vault_key.des.key_size == 4096
    error_message  = "keyvault key key_type must be set to 4096 by default"
  }

  assert {
    condition      = azurerm_key_vault_key.des.rotation_policy[0].automatic[0].time_before_expiry == "P7D"
    error_message  = "keyvault key rotation_policy.automatic.time_before_expiry must be set to P7D by default"
  }

  assert {
    condition      = azurerm_key_vault_key.des.rotation_policy[0].expire_after == "P30D"
    error_message  = "keyvault key rotation_policy.expire_after must be set to P30D by default"
  }

  assert {
    condition      = azurerm_key_vault_key.des.rotation_policy[0].notify_before_expiry == "P7D"
    error_message  = "keyvault key rotation_policy.notify_before_expiry must be set to P7D by default"
  }

  assert {
    condition      = azurerm_key_vault_key.des.expiration_date == null
    error_message  = "keyvault key expiration_date must be null by default"
  }

  assert {
    condition       = length(azurerm_key_vault_key.des.tags) == 1
    error_message  = "keyvault key tags must contains one element"
  }

  assert {
    condition      = azurerm_disk_encryption_set.des.name == var.name
    error_message  = "des name must be set"
  }

  assert {
    condition      = azurerm_disk_encryption_set.des.resource_group_name == var.resource_group_name
    error_message  = "des resource_group_name must be set"
  }

  assert {
    condition      = azurerm_disk_encryption_set.des.location == var.location
    error_message  = "des location must be set"
  }

  assert {
    condition      = azurerm_disk_encryption_set.des.identity[0].type == "UserAssigned"
    error_message  = "des identity.type must be set to UserAssigned"
  }

  assert {
    condition      = contains(azurerm_disk_encryption_set.des.identity[0].identity_ids, var.identity_id)
    error_message  = "des identity.identity_ids must contains var.identity_id"
  }

  assert {
    condition       = length(azurerm_disk_encryption_set.des.tags) == 1
    error_message  = "des tags must contains one element"
  }
}