output "id" {
  description = "The Role Assignment ID"
  value       = azurerm_role_assignment.iam.id
}

output "principal_type" {
  description = "The type of the principal_id, e.g. User, Group, Service Principal, Application, etc"
  value       = azurerm_role_assignment.iam.principal_type
}
