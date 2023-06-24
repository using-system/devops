resource "azurerm_container_app_environment" "acae" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  infrastructure_subnet_id       = var.subnet_id
  internal_load_balancer_enabled = var.internal_load_balancer_enabled
  log_analytics_workspace_id     = var.log_analytics_workspace_id

  tags = var.tags
}
