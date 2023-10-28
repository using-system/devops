resource "azurerm_container_registry" "acr" {

  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku = var.sku

  admin_enabled = var.admin_enabled

  quarantine_policy_enabled = var.quarantine_policy_enabled
  trust_policy {
    enabled = var.trust_policy_enabled
  }
  retention_policy {
    enabled = var.retention_policy_enabled
    days    = var.retention_policy_days
  }

  dynamic "georeplications" {
    for_each = var.georeplication_locations

    content {
      location = georeplications.value
    }
  }

  identity {
    type         = var.identity_type
    identity_ids = var.identity_ids
  }

  public_network_access_enabled = var.public_network_access_enabled
  network_rule_bypass_option    = var.network_rule_bypass_option


  tags = var.tags
}

resource "azurerm_management_lock" "acr" {

  depends_on = [azurerm_container_registry.acr]

  count = (var.enable_lock_on_acr == true ? 1 : 0)

  name       = "${var.name}-lock"
  scope      = azurerm_container_registry.acr.id
  lock_level = "CanNotDelete"
}
