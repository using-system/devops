resource "azurerm_container_app" "aca" {
  name                         = var.name
  container_app_environment_id = var.container_app_environment_id
  resource_group_name          = var.resource_group_name
  revision_mode                = var.revision_mode

  template {
    min_replicas = var.min_replicas
    max_replicas = var.max_replicas

    container {
      name   = "containerapp"
      image  = var.image
      cpu    = var.cpu
      memory = var.memory

      dynamic "env" {
        for_each = var.environment_variables
        content {
          name        = environment_variable.value.name
          value       = environment_variable.value.value
          secret_name = environment_variable.value.secret_name
        }
      }

    }
  }

  identity {
    type         = var.identity_type
    identity_ids = var.identity_ids
  }

  dynamic "ingress" {
    for_each = var.enable_ingress ? [1] : []
    content {
      allow_insecure_connections = var.allow_insecure_connections
      external_enabled           = var.external_enabled
      target_port                = var.target_port
    }
  }
}
