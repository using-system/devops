variable location {
  description = "Azure Region Location"
}

variable naming {
  description = "Naming for prefix for resources"
}

variable configuration {
  description     = "VNET configuration"
  type            = object({
    address_spaces            = list(string)
    k8s_sbunet_name           = string
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