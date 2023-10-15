data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "test" {
  name = "tf-test-rg"
}

resource "azurerm_user_assigned_identity" "test" {
  location            = data.azurerm_resource_group.test.location
  name                = "az-des-test-identity"
  resource_group_name = data.azurerm_resource_group.test.name
}

resource "azurerm_key_vault" "test" {
  name                        = "az-des-test-kv"
  location                    = data.azurerm_resource_group.test.location
  resource_group_name         = data.azurerm_resource_group.test.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "premium"
  enabled_for_disk_encryption = true
  purge_protection_enabled    = true
}


output "resource_group_name" {
  value = data.azurerm_resource_group.test.name
}

output "resource_group_location" {
  value = data.azurerm_resource_group.test.location
}

output "identity_id" {
  value = azurerm_user_assigned_identity.test.id
}

output "principal_id" {
  value = azurerm_user_assigned_identity.test.principal_id
}

output "kv_id" {
  value = azurerm_key_vault.test.id
}
