data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {
  name                            = var.name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  tenant_id                       = data.azurerm_client_config.current.tenant_id

  sku_name                        = var.sku
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  soft_delete_retention_days      = var.soft_delete_retention_days
  purge_protection_enabled        = var.purge_protection_enabled

  network_acls {
      bypass                        = var.network_rules_bypass
      default_action                = var.network_rules_default_action
      virtual_network_subnet_ids    = var.network_subnet_ids
  }

  tags                            = var.tags

  lifecycle {
       ignore_changes = [ network_acls[0].ip_rules ]
  }  
}
/*
resource "azurerm_monitor_diagnostic_setting" "keyvault" {
  name                          = "keyvault-logging"
  target_resource_id            = azurerm_key_vault.keyvault.id

  log_analytics_workspace_id    = var.log_analytics_workspace_id

  enabled_log {
    category                    = "AuditEvent"
    
    retention_policy {
      enabled = true
      days = 30
    }
  }

  metric {
    category = "AllMetrics"
    enabled  = false

    retention_policy {
      days    = 0
      enabled = false
    }
  }
}*/