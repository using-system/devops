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

  expiration_date = var.expiration_date
}
