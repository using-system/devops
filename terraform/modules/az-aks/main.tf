resource "tls_private_key" "aks" {
  count = var.configuration.admin_username == null ? 0 : 1

  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_kubernetes_cluster" "aks" {

  name                   = var.name
  location               = var.location
  resource_group_name    = var.resource_group_name
  dns_prefix             = var.name
  kubernetes_version     = var.configuration.version
  sku_tier               = var.configuration.sku
  disk_encryption_set_id = var.configuration.disk_encryption_set_id


  private_cluster_enabled   = var.configuration.private_cluster
  local_account_disabled    = var.configuration.local_account_disabled
  automatic_channel_upgrade = var.configuration.automatic_channel_upgrade
  private_dns_zone_id       = var.private_dns_zone_id

  default_node_pool {
    name                         = "defaultpool"
    node_count                   = var.configuration.node_pool.count
    vm_size                      = var.configuration.node_pool.vm_size
    zones                        = var.configuration.node_pool.availability_zones
    os_disk_type                 = "Ephemeral"
    os_disk_size_gb              = var.configuration.node_pool.os_disk_size
    type                         = var.configuration.node_pool.type
    vnet_subnet_id               = var.subnet_id
    max_pods                     = var.configuration.node_pool.max_pods
    temporary_name_for_rotation  = var.configuration.node_pool.temporary_name_for_rotation
    enable_host_encryption       = true
    only_critical_addons_enabled = var.configuration.node_pool.only_critical_addons_enabled

    upgrade_settings {
      max_surge = var.configuration.node_pool.upgrade_max_surge
    }
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [var.configuration.user_assigned_identity_id]
  }

  azure_policy_enabled      = var.configuration.addon.enable_azure_policy
  open_service_mesh_enabled = var.configuration.addon.enable_open_service_mesh
  dynamic "service_mesh_profile" {
    for_each = var.configuration.addon.service_mesh_profile == null ? [] : ["service_mesh_profile"]
    content {
      mode                             = var.configuration.addon.service_mesh_profile.mode
      external_ingress_gateway_enabled = var.configuration.addon.service_mesh_profile.external_ingress_gateway_enabled
      internal_ingress_gateway_enabled = var.configuration.addon.service_mesh_profile.internal_ingress_gateway_enabled
    }
  }

  dynamic "oms_agent" { # Azure Monitor for containers
    for_each = var.configuration.addon.enable_oms_agent ? ["oms_agent"] : []
    content {
      log_analytics_workspace_id      = var.log_analytics_id
      msi_auth_for_monitoring_enabled = var.configuration.msi_auth_for_monitoring_enabled
    }
  }

  dynamic "microsoft_defender" {
    for_each = var.configuration.enable_microsoft_defender == false ? [] : ["microsoft_defender"]
    content {
      log_analytics_workspace_id = var.log_analytics_id
    }
  }
  dynamic "key_management_service" {
    for_each = var.configuration.kv_key_management_service_id == null ? [] : ["key_management_service"]

    content {
      key_vault_key_id         = var.configuration.kv_key_management_service_id
      key_vault_network_access = "Private"
    }
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  dynamic "linux_profile" {
    for_each = var.configuration.admin_username == null ? [] : ["linux_profile"]

    content {
      admin_username = var.configuration.admin_username

      ssh_key {
        key_data = replace(coalesce(var.configuration.public_ssh_key, tls_private_key.aks[0].public_key_openssh), "\n", "")
      }
    }
  }

  network_profile {
    network_plugin    = var.configuration.network_profile.network_plugin
    network_policy    = var.configuration.network_profile.network_policy
    load_balancer_sku = var.configuration.network_profile.load_balancer_sku
    outbound_type     = var.configuration.network_profile.outbound_type
  }

  azure_active_directory_role_based_access_control {
    managed                = true
    admin_group_object_ids = var.configuration.rbac.admin_group_object_ids
    azure_rbac_enabled     = var.configuration.rbac.enabled
    tenant_id              = var.configuration.rbac.tenant_id
  }

  dynamic "monitor_metrics" {
    for_each = var.configuration.monitor_metrics != null ? ["monitor_metrics"] : []

    content {
      annotations_allowed = var.configuration.monitor_metrics.annotations_allowed
      labels_allowed      = var.configuration.monitor_metrics.labels_allowed
    }
  }

  tags = var.tags
}
