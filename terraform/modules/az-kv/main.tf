data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku_name                        = var.sku
  enable_rbac_authorization       = var.enable_rbac_authorization
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  soft_delete_retention_days      = var.soft_delete_retention_days
  purge_protection_enabled        = var.purge_protection_enabled

  network_acls {
    bypass                     = var.network_rules_bypass
    default_action             = var.network_rules_default_action
    virtual_network_subnet_ids = var.network_subnet_ids
  }
  public_network_access_enabled = var.public_network_access_enabled

  tags = var.tags

  lifecycle {
    precondition {
      condition     = (var.purge_protection_enabled && var.soft_delete_retention_days >= 7) || var.purge_protection_enabled == false
      error_message = "Purge protection must be disabled or soft delete retention days must be greater than or equal to 7"
    }
  }
}
