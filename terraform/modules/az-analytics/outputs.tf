output "id" {
  description = "The Log Analytics Workspace ID"
  value       = azurerm_log_analytics_workspace.monitoring.id
}

output "primary_shared_key" {
  description = "The Primary shared key for the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.monitoring.primary_shared_key
  sensitive   = true
}

output "secondary_shared_key" {
  description = "The Secondary  shared key for the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.monitoring.primary_shared_key
  sensitive   = true
}

output "workspace_id" {
  description = "The Workspace (or Customer) ID for the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.monitoring.workspace_id
}
