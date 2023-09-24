locals {
  identity_ids_with_index = { for idx, id in var.identity_ids : idx => id }
}


resource "azurerm_key_vault_key" "des" {
  name         = var.name
  key_vault_id = var.kv_id
  key_type     = "RSA-HSM"
  key_size     = var.key_size

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]

  rotation_policy {
    automatic {
      time_before_expiry = var.auto_rotation_time_before_expiry
    }

    expire_after         = var.rotation_expire_after
    notify_before_expiry = var.rotation_notify_before_expiry
  }

  expiration_date = var.expiration_date
}

resource "azurerm_disk_encryption_set" "des" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  key_vault_key_id    = azurerm_key_vault_key.des.id

  identity {
    type         = "UserAssigned"
    identity_ids = var.identity_ids
  }

  tags = var.tags
}

resource "azurerm_role_assignment" "des" {
  for_each = local.identity_ids_with_index

  scope                = var.kv_id
  role_definition_name = "Key Vault Crypto Service Encryption User"
  principal_id         = each.value
}
