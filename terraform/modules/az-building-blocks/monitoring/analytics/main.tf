resource "azurerm_log_analytics_workspace" "monitor" {

  depends_on = [ azurerm_resource_group.monitor ] 

  name                      = "${var.naming}-analytics"
  location                  = var.location
  resource_group_name       = var.resource_group_name

  sku                       = var.configuration.sku
  retention_in_days         = var.configuration.retention_in_days  
}