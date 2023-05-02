variable location {
  description = "Azure Region Location"
}

variable resource_group_name {
  description = "Resource group name of the vnet"
}

variable network_security_groups {
  description     = "Network security groups to create"
  type            = list(object({
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
}

variable tags {
  description = "Tags to associate with resources."
  type        = map(string)
}