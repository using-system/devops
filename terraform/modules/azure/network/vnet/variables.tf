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
          priority                                          = list(string)
          direction                                         = list(string)
          access                                            = bool
          protocol                                          = bool
          source_address_prefix                             = string
          source_port_range                                 = list(string)
          destination_address_prefix                        = list(string)
          destination_port_range                            = bool
          protocol                                          = bool
          }))
    }))
    subnets                   = list(object({
          name                                              = string
          address_prefixes                                  = list(string)
          service_endpoints                                 = list(string)
          private_link_service_network_policies_enabled     = bool
          private_endpoint_network_policies_enabled         = bool
    }))
  })  
}

variable tags {
  description = "Tags to associate with resources."
  type        = map(string)
}