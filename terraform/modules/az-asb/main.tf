resource "azurerm_servicebus_namespace" "asb" {
  name                         = var.name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  sku                          = var.sku
  capacity                     = var.capacity
  premium_messaging_partitions = var.premium_messaging_partitions

  public_network_access_enabled = var.public_network_access_enabled
  local_auth_enabled            = false
  minimum_tls_version           = var.minimum_tls_version

  dynamic "network_rule_set" {
    for_each = length(var.subnet_ids) > 0 ? [1] : []
    content {
      public_network_access_enabled = var.public_network_access_enabled
      default_action                = var.network_rules_default_action
      trusted_services_allowed      = var.trusted_services_allowed

      dynamic "network_rules" {
        for_each = var.subnet_ids
        content {
          subnet_id = network_rules.value
        }
      }
    }
  }

  dynamic "identity" {
    for_each = length(var.identity_ids) > 0 ? [1] : []
    content {
      type         = "UserAssigned"
      identity_ids = var.identity_ids
    }
  }

  dynamic "customer_managed_key" {
    for_each = var.cmk_key_vault_key_id != null && length(var.identity_ids) > 0 ? [1] : []
    content {
      key_vault_key_id                  = var.cmk_key_vault_key_id
      identity_id                       = var.identity_ids[0]
      infrastructure_encryption_enabled = true
    }
  }

  tags = var.tags
}
