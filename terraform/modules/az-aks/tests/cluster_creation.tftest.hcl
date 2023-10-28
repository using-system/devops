provider "azurerm" {
  features {
  }
}

run "setup" {
  module {
    source = "./tests/setup"
  }
}

run "plan" {

  command = plan

  variables {
    location                = run.setup.resource_group_location
    resource_group_name     = run.setup.resource_group_name
    name                    = "az-aks-cluster"
    configuration           = {
        version                      = "1.27.3"
        sku                          = "Free"
        private_cluster              = true
        user_assigned_identity_id    = run.setup.assigned_identity_id
        local_account_disabled       = true
        node_pool = {
            type                        = "VirtualMachineScaleSets"
            count                       = 2
            vm_size                     = "standard_dc2s_v2"
            availability_zones          = [2, 3]
            os_disk_type                = "Ephemeral"
            os_disk_size                = 30
            temporary_name_for_rotation = "nodepoolrot"
        }
        rbac = {
            enabled                = true
            tenant_id              = run.setup.tenant_id
        }
        addon = {
            enable_open_service_mesh = true
            enable_azure_policy      = true
        }
        network_profile = {
            network_plugin = "kubenet"
            network_policy = "calico"
            outbound_type  = "loadBalancer"
        }
    }

    log_analytics_id        = run.setup.log_analytics_id
    subnet_id               = run.setup.subnet_id

    tags                    = { Environment = "Test" }
  }

  assert {
    condition      = azurerm_kubernetes_cluster.aks.name == var.name
    error_message  = "azurerm_kubernetes_cluster name must be set"
  }

  assert {
    condition      = azurerm_kubernetes_cluster.aks.location == var.location
    error_message  = "azurerm_kubernetes_cluster location must be set"
  }

  assert {
    condition      = azurerm_kubernetes_cluster.aks.resource_group_name == var.resource_group_name
    error_message  = "azurerm_kubernetes_cluster resource_group_name must be set"
  }

  assert {
    condition      = azurerm_kubernetes_cluster.aks.dns_prefix == var.name
    error_message  = "azurerm_kubernetes_cluster dns_prefix must be set"
  }

  assert {
    condition      = azurerm_kubernetes_cluster.aks.kubernetes_version == var.configuration.version
    error_message  = "azurerm_kubernetes_cluster kubernetes_version must be set"
  }

  assert {
    condition      = azurerm_kubernetes_cluster.aks.sku_tier == var.configuration.sku
    error_message  = "azurerm_kubernetes_cluster sku_tier must be set"
  }

  assert {
    condition       = length(azurerm_kubernetes_cluster.aks.tags) == 1
    error_message  = "azurerm_kubernetes_cluster tags must contains one element"
  }

}

run "apply" {

    command = apply

    variables {
        location                = run.setup.resource_group_location
        resource_group_name     = run.setup.resource_group_name
        name                    = "az-aks-cluster"
        configuration           = {
            version                      = "1.27.3"
            sku                          = "Free"
            private_cluster              = true
            user_assigned_identity_id    = run.setup.assigned_identity_id
            local_account_disabled       = true
            node_pool = {
                type                        = "VirtualMachineScaleSets"
                count                       = 2
                vm_size                     = "standard_dc2s_v2"
                availability_zones          = [2, 3]
                os_disk_type                = "Ephemeral"
                os_disk_size                = 30
                temporary_name_for_rotation = "nodepoolrot"
            }
            rbac = {
                enabled                = true
                tenant_id              = run.setup.tenant_id
            }
            addon = {
                enable_open_service_mesh = true
                enable_azure_policy      = true
            }
            network_profile = {
                network_plugin = "kubenet"
                network_policy = "calico"
                outbound_type  = "loadBalancer"
            }
        }

        log_analytics_id        = run.setup.log_analytics_id
        subnet_id               = run.setup.subnet_id

        tags                    = { Environment = "Test" }
    }


    assert {
        condition       = output.id != "" && output.id != null
        error_message  = "output id is empty"
    }
}