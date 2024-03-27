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
  default     = false
}

variable "public_network_access_enabled" {
  description = "Determines if the public network access is enabled"
  type        = bool
  default     = false
}

variable "network_rule_bypass_option" {
  description = "Determines if the network rule bypass option is enabled"
  type        = string
  default     = "None"
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

variable "trust_policy_enabled" {
  description = "Determines if the trust policy is enabled"
  type        = bool
  default     = true
}

variable "zone_redundancy_enabled" {
  description = "Determines if the zone redundancy is enabled"
  type        = bool
  default     = true
}

variable "identity_type" {
  description = "The type of identity used for the acr."
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "A list of identities associated with the acr."
  type        = list(string)
  default     = []
}

variable "ip_rules" {
  description = "List of IP rules to allow on the acr."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to associate with resources."
  type        = map(string)
}
