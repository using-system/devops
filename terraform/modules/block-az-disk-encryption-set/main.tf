resource "azurerm_key_vault_key" "encryption_set" {
  name         = var.name
  key_vault_id = var.key_vault_id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}

resource "azurerm_disk_encryption_set" "encryption_set" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  key_vault_key_id    = azurerm_key_vault_key.encryption_set.id

  identity {
    type         = "UserAssigned"
    identity_ids = var.identity_ids
  }

  tags = var.tags
}
