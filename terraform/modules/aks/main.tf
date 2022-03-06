resource "azurerm_resource_group" "aks" {
  name                      =  "${var.naming}-aks-rg"
  location                  =  var.location
  tags                      =  var.tags
}

resource "azurerm_user_assigned_identity" "aks" {

    depends_on = [ azurerm_resource_group.aks ]

    location                        = var.location
    resource_group_name             = azurerm_resource_group.aks.name
    name                            = "${var.naming}-aks-identity"  
}


resource "azurerm_role_assignment" "aks_user_assigned_network" {

  depends_on = [ azurerm_user_assigned_identity.aks ]

  principal_id                    = azurerm_user_assigned_identity.aks.principal_id
  scope                           = format("/subscriptions/%s/resourceGroups/%s", var.subscription_id, "${var.naming}-network-rg")
  role_definition_name            = "Contributor"
}

resource "azurerm_kubernetes_cluster" "aks" {

  depends_on = [ azurerm_user_assigned_identity.aks, azurerm_role_assignment.aks_user_assigned_network ]

  name                            = "${var.naming}-aks"
  location                        = azurerm_resource_group.aks.location
  resource_group_name             = azurerm_resource_group.aks.name
  dns_prefix                      = "${var.naming}-aks"
  kubernetes_version              = var.configuration.version
  sku_tier                        = var.configuration.sku

  private_cluster_enabled         = var.configuration.private_cluster
  
  default_node_pool {
    name                          = "defaultpool"
    node_count                    = var.configuration.node_pool.count
    vm_size                       = var.configuration.node_pool.vm_size
    availability_zones            = var.configuration.node_pool.availability_zones
    os_disk_type                  = var.configuration.node_pool.os_disk_type
    os_disk_size_gb               = var.configuration.node_pool.os_disk_size
    type                          = var.configuration.node_pool.type
    vnet_subnet_id                = var.subnet_id
  }

  identity {
    type                          =  "UserAssigned"
    user_assigned_identity_id     = azurerm_user_assigned_identity.aks.id
  }

  azure_policy_enabled            = var.configuration.addon.enable_azure_policy
  open_service_mesh_enabled       = var.configuration.addon.enable_open_service_mesh
  oms_agent {
      log_analytics_workspace_id  = var.log_analytics_id
    }

  linux_profile {
         admin_username           = var.configuration.admin_username
         ssh_key {
             key_data             = chomp(var.configuration.admin_ssh_key) 
         }
  }

  network_profile {
    network_plugin                = "kubenet"
    network_policy                = "calico"
    load_balancer_sku             = "standard"
    outbound_type                 = "userDefinedRouting"
  }

  role_based_access_control {
    enabled                       = true
  }

  tags                            =  var.tags
}

resource "azurerm_role_assignment" "aks_user_assigned_infra" {

  principal_id                    = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  scope                           = format("/subscriptions/%s/resourceGroups/%s", var.subscription_id, azurerm_kubernetes_cluster.aks.node_resource_group)
  role_definition_name            = "Contributor"
}
