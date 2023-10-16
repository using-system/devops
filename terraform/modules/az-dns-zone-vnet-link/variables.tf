variable "resource_group_name" {
  description = "The name of the resource group in which to create the private endpoint connection."
  type        = string
}

variable "name" {
  description = "The name of the link connection."
  type        = string
}

variable "private_dns_zone_name" {
  description = "The name of the private DNS zone."
  type        = string
}

variable "vnet_id" {
  description = "The ID of the virtual network."
  type        = string
}

variable "registration_enabled" {
  description = "Is auto-registration of virtual machine records in the virtual network in the private DNS zone enabled?"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to associate with resources."
  type        = map(string)
}
