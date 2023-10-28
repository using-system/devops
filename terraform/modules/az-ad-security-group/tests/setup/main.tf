data "azuread_client_config" "current" {}

output "app_object_id" {
  value = data.azuread_client_config.current.object_id
}
