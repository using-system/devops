resource "azurerm_key_vault_key" "key" {
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

  dynamic "rotation_policy" {
    for_each = var.rotation == null ? [] : ["rotation_policy"]

    content {
      automatic {
        time_before_expiry = var.rotation.auto_rotatation_time_before_expiry
      }

      expire_after         = var.rotation.expire_after
      notify_before_expiry = var.rotation.notify_before_expiry
    }
  }

  expiration_date = var.static_expiration_date

  tags = var.tags
}
