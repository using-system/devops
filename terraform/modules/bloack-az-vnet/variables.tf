variable location {
  description = "Azure Region Location"
}

variable name {
  description = "Name of the vnet to create"
}

variable resource_group_name {
  description = "Resource group name of the vnet"
}

variable configuration {
  description     = "VNET configuration"
  type            = object({
    address_spaces            = list(string)
    subnets                   = list(object({
          name                                              = string
          address_prefixes                                  = list(string)
          service_endpoints                                 = list(string)
          private_link_service_network_policies_enabled     = bool
          private_endpoint_network_policies_enabled         = bool
          network_security_group                            = string
          route_table                                       = string
    }))
  })  
}

variable tags {
  description = "Tags to associate with resources."
  type        = map(string)
}