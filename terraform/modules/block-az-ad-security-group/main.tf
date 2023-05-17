data "azuread_client_config" "current" {}

resource "azuread_group" "aad_group" {
  display_name     = var.name
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
}
