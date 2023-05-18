variable "name" {
  description = "Name of the container app environment."
}

variable "location" {
  description = "Azure Region Location"
}

variable "resource_group_name" {
  description = "Resource group name of the acae"
}

variable "sku" {
  description = "The SKU name of the container registry."
}

variable "admin_enabled" {
  description = "Determines if the admin user is enabled"
  type        = bool
}

variable "tags" {
  description = "Tags to associate with resources."
  type        = map(string)
}
