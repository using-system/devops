resource "azurerm_container_registry" "acr" {

  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = var.sku
  admin_enabled                 = var.admin_enabled
  public_network_access_enabled = var.public_network_access_enabled
  network_rule_bypass_option    = var.network_rule_bypass_option

  tags = var.tags
}

resource "azurerm_management_lock" "acr" {

  depends_on = [azurerm_container_registry.acr]

  name       = "${var.name}-lock"
  scope      = azurerm_container_registry.acr.id
  lock_level = "CanNotDelete"
}
