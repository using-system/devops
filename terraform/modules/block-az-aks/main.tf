resource "azurerm_kubernetes_cluster" "aks" {

  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.name
  kubernetes_version  = var.configuration.version
  sku_tier            = var.configuration.sku

  private_cluster_enabled = var.configuration.private_cluster

  default_node_pool {
    name            = "defaultpool"
    node_count      = var.configuration.node_pool.count
    vm_size         = var.configuration.node_pool.vm_size
    zones           = var.configuration.node_pool.availability_zones
    os_disk_type    = var.configuration.node_pool.os_disk_type
    os_disk_size_gb = var.configuration.node_pool.os_disk_size
    type            = var.configuration.node_pool.type
    vnet_subnet_id  = var.subnet_id
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [var.configuration.user_assigned_identity_id]
  }

  azure_policy_enabled      = var.configuration.addon.enable_azure_policy
  open_service_mesh_enabled = var.configuration.addon.enable_open_service_mesh
  oms_agent {
    log_analytics_workspace_id = var.log_analytics_id
  }

  linux_profile {
    admin_username = var.configuration.admin_username
    ssh_key {
      key_data = chomp(var.configuration.admin_public_ssh_key)
    }
  }

  network_profile {
    network_plugin    = "kubenet"
    network_policy    = "calico"
    load_balancer_sku = "standard"
    outbound_type     = "userDefinedRouting"
  }

  azure_active_directory_role_based_access_control {
    managed = true
  }

  tags = var.tags
}
