resource "azurerm_key_vault_key" "cust_managed_key" {
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

  rotation_policy {
    automatic {
      time_before_expiry = var.rotation.auto_rotatation_time_before_expiry
    }

    expire_after         = var.rotation.expire_after
    notify_before_expiry = var.rotation.notify_before_expiry
  }
}
