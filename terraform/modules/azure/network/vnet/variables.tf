variable location {
  description = "Azure Region Location"
}

variable name {
  description = "Name of the vnet to create"
}

variable resource_group_name {
  description = "Resource group name of the vnet"
}

variable create_resource_group {
  description = "Resource group name of the vnet"
  type        = bool
  default     = true
}

variable configuration {
  description     = "VNET configuration"
  type            = object({
    address_spaces            = list(string)
    network_security_groups   = list(object({
        name                                              = string
        rules                                             = list(object({
          name                                              = string
          priority                                          = string
          direction                                         = string
          access                                            = string
          protocol                                          = string
          source_address_prefix                             = string
          source_port_range                                 = string
          destination_address_prefix                        = string
          destination_port_range                            = string
          }))
    }))
    route_tables              = list(object({
        name                                              = string
        disable_bgp_route_propagation                     = bool
        routes                                              = list(object({
          name                                              = string
          address_prefix                                    = string
          next_hop_type                                     = string
          next_hop_in_ip_address                            = string
          }))
    }))
    subnets                   = list(object({
          name                                              = string
          address_prefixes                                  = list(string)
          service_endpoints                                 = list(string)
          private_link_service_network_policies_enabled     = bool
          private_endpoint_network_policies_enabled         = bool
          network_security_group                            = string
    }))
  })  
}

variable tags {
  description = "Tags to associate with resources."
  type        = map(string)
}