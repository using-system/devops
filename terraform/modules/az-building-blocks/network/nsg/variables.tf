variable location {
  description = "Azure Region Location"
}

variable resource_group_name {
  description = "Resource group name of the vnet"
}

variable network_security_groups {
  description     = "Network security groups to create"
  type            = object({
    name                                              = string
    disable_bgp_route_propagation                     = bool
    routes                                            = list(object({
        name                                          = string
        address_prefix                                = string
        next_hop_type                                 = string
        next_hop_in_ip_address                        = string
          }))
    })
}

variable tags {
  description = "Tags to associate with resources."
  type        = map(string)
}