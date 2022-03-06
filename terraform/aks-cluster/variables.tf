#------------------------------------------------------------------------------
# Global
#------------------------------------------------------------------------------

variable tenant_id {
  description = "Azure AAd Tenant ID"
}

variable subscription_id {
  description = "Azure Subscription Identifier"
}

variable location {
  description = "Azure Region Location"
  default     = "westeurope"
}

variable naming {
  description = "Naming for prefix for resources"
}

variable tags {
  description = "Tags to associate with resources."
  type        = map(string)
}


#------------------------------------------------------------------------------
# Monitoring
#------------------------------------------------------------------------------

variable monitor_configuration {
  description   = "Azure Monitor configuration"
  type          = object({
    sku                         = string
    retention_in_days           = number
  })  
}

#------------------------------------------------------------------------------
# Networking
#------------------------------------------------------------------------------

variable network_configuration {
  description     = "VNET configuration"
  type            = object({
    address_spaces            = list(string)
    k8s_sbunet_name           = string
    subnets                   = list(object({
          name                                              = string
          address_prefixes                                  = list(string)
          service_endpoints                                 = list(string)
          enforce_private_link_service_network_policies     = bool
          enforce_private_link_endpoint_network_policies    = bool
    }))
  })  
}

#------------------------------------------------------------------------------
# AKS
#------------------------------------------------------------------------------

variable aks_configuration {
  description     = "AKS configuration"
  type            = object({
    version                     = string
    sku                         = string
    private_cluster             = bool
    admin_username              = string
    admin_ssh_key               = string
    node_pool                   = object({
      type                                    = string
      count                                   = number
      vm_size                                 = string
      availability_zones                      = list(number)
      os_disk_type                            = string
      os_disk_size                            = number
    })
    addon                      = object({
      enable_open_service_mesh               = bool
      enable_azure_policy                    = bool
    })

  })  
}