variable "name" {
  description = "Peering name"
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the peering"
}

variable "virtual_network_name" {
  description = "Virtual network name"
}

variable "remote_virtual_network_id" {
  description = "Remote virtual network id"
}

variable "allow_virtual_network_access" {
  description = " Controls if the VMs in the remote virtual network can access VMs in the local virtual network"
  default     = true
}

variable "allow_forwarded_traffic" {
  description = "Controls if forwarded traffic from VMs in the remote virtual network is allowed"
  default     = false
}

variable "allow_gateway_transit" {
  description = "Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network"
  default     = false
}

variable "use_remote_gateways" {
  description = "Controls if remote gateways can be used on this virtual network. If the flag is set to true, and allow_gateway_transit on the remote virtual network is also true, virtual network will use gateways of remote virtual network for transit"
  default     = false
}
