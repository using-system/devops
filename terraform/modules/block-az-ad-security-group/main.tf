resource "azuread_group" "aad_group" {
  display_name     = var.name
  owners           = var.owners
  security_enabled = true
}
