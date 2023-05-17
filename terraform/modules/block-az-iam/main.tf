resource "azurerm_role_assignment" "iam" {
  scope                = var.scope
  role_definition_name = var.role_name
  principal_id         = var.principal_id
}
