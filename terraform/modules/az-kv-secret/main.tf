resource "azurerm_key_vault_secret" "keyvault" {

  key_vault_id = var.kv_id

  name  = var.secret_name
  value = var.secret_value

  content_type    = var.content_type
  expiration_date = var.expiration_date
}
