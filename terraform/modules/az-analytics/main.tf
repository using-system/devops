resource "azurerm_log_analytics_workspace" "monitoring" {

  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku               = var.configuration.sku
  retention_in_days = var.configuration.retention_in_days

  internet_ingestion_enabled = var.configuration.internet_ingestion_enabled
  internet_query_enabled     = var.configuration.internet_query_enabled

  tags = var.tags
}
