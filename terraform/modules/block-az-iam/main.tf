resource "azurerm_role_assignment" "example" {
  scope                = var.scope
  role_definition_name = var.role_name
  principal_id         = var.principal_id
}
