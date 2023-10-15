
data "azurerm_client_config" "current" {
}

resource "azuread_group" "test" {
  display_name     = "azadsecuritygroupmemberstest"
  security_enabled = true
}

output "group_object_id" {
  value = azuread_group.test.object_id
}

output "member_object_id" {
  value = data.azurerm_client_config.current.object_id
}
