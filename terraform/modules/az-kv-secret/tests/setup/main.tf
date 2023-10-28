data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "test" {
  name = "tf-test-rg"
}

resource "azurerm_key_vault" "kv" {
  name                      = "systemazkvsecretkv"
  location                  = data.azurerm_resource_group.test.location
  resource_group_name       = data.azurerm_resource_group.test.name
  tenant_id                 = data.azurerm_client_config.current.tenant_id
  sku_name                  = "premium"
  enable_rbac_authorization = true
}

resource "azurerm_role_assignment" "kv" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}

output "kv_id" {
  value       = azurerm_key_vault.kv.id
  description = "The Key Vault ID"
}
