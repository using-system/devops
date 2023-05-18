variable "name" {
  description = "Name of the acr"
}

variable "location" {
  description = "Azure Region Location"
}

variable "resource_group_name" {
  description = "Resource group name of the acr"
}

variable "sku" {
  description = "The SKU name of the container registry."
}

variable "admin_enabled" {
  description = "Determines if the admin user is enabled"
  type        = bool
}

variable "public_network_access_enabled" {
  description = "Determines if the public network access is enabled"
  type        = bool
}

variable "network_rule_bypass_option" {
  description = "Determines if the network rule bypass option is enabled"
  type        = string
}

variable "tags" {
  description = "Tags to associate with resources."
  type        = map(string)
}
