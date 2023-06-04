variable "resource_group_name" {
  description = "The name of the resource group in which to create the Key Vault."
  type        = string
}

variable "location" {
  description = "The Azure location where the Key Vault should be created."
  type        = string
}

variable "name" {
  description = "The name of the Key Vault."
  type        = string
}

variable "sku" {
  description = "The name of the SKU for the Key Vault."
  type        = string
  default     = "standard"
}

variable "enable_rbac_authorization" {
  description = "value to enable RBAC authorization for the Key Vault."
  type        = bool
  default     = true
}

variable "enabled_for_disk_encryption" {
  description = "Specifies if Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys."
  type        = bool
  default     = false
}

variable "enabled_for_template_deployment" {
  description = "Specifies if Azure Resource Manager is permitted to retrieve secrets from the vault."
  type        = bool
  default     = false
}

variable "soft_delete_retention_days" {
  description = "The number of days that items should be retained for once soft-deleted."
  type        = number
  default     = 7
}

variable "network_rules_bypass" {
  description = "Specifies which traffic can bypass the network rules. Possible values are AzureServices and None."
  type        = string
  default     = "AzureServices"
}

variable "network_rules_default_action" {
  description = "The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny"
  type        = string
  default     = "Allow"
}

variable "network_subnet_ids" {
  description = "One or more Subnet IDs which should be able to access this Key Vault."
  type        = list(string)
  default     = null
}

variable "public_network_access_enabled" {
  description = "Whether or not public network access is allowed for the key vault."
  type        = bool
  default     = false
}


variable "log_analytics_workspace_id" {
  description = "Log analytics workspace id where to save diag audit event"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to associate with resources."
  type        = map(string)
}
