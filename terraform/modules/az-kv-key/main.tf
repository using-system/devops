resource "azurerm_key_vault_key" "key" {
  name         = var.name
  key_vault_id = var.kv_id
  key_type     = "RSA-HSM"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]

  dynamic "rotation_policy" {
    for_each = var.rotation.expiration_date == null ? [] : ["rotation_policy"]

    content {
      automatic {
        time_before_expiry = var.rotation.auto_rotatation_time_before_expiry
      }

      expire_after         = var.rotation.expire_after
      notify_before_expiry = var.rotation.notify_before_expiry
    }
  }

  expiration_date = var.rotation.expiration_date

  lifecycle {
    precondition {
      condition     = (var.rotation.expiration_date == null && var.rotation.expire_after != null) || (var.rotation.expiration_date != null && var.rotation.expire_after == null) || (var.rotation.expiration_date == null && var.rotation.expire_after == null)
      error_message = "Either expiration_date or expire_after must be set"
    }
  }
}
