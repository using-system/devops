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
  default     = "Premium"
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

variable "enable_lock_on_acr" {
  description = "Determines if the lock on acr is enabled"
  type        = bool
  default     = true
}

variable "georeplication_locations" {
  description = "List of locations for the georeplication"
  type        = list(string)
  default     = []
}

variable "retention_policy_enabled" {
  description = "Determines if the retention policy is enabled"
  type        = bool
  default     = true
}

variable "retention_policy_days" {
  description = "Number of days to retain an untagged manifest after which it gets purged"
  type        = number
  default     = 7
}

variable "quarantine_policy_enabled" {
  description = "Determines if the quarantine policy is enabled"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to associate with resources."
  type        = map(string)
}
