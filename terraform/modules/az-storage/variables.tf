variable "resource_group_name" {
  description = "The name of the resource group in which to create the storage account."
  type        = string
}

variable "name" {
  description = "Specifies the name of the storage account."
  type        = string
}

variable "location" {
  description = "The location of the resource group in which to create the storage account."
  type        = string
}

variable "account_tier" {
  description = "Defines the Tier to use for this storage account."
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Defines the type of replication to use for this storage account."
  type        = string
  default     = "GRS"
}

variable "enable_https_traffic_only" {
  description = "Enables https traffic only to storage service if set to true."
  type        = bool
  default     = true
}

variable "min_tls_version" {
  description = "The minimum supported TLS version for the storage account."
  type        = string
  default     = "TLS1_2"
}

variable "shared_access_key_enabled" {
  description = "Specifies whether the storage account permits requests to be authorized with the account access key via Shared Key."
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Specifies whether or not public network access is allowed for the storage account."
  type        = bool
  default     = false
}

variable "allow_nested_items_to_be_public" {
  description = "Specifies whether or not public access is allowed on the blobs within the container."
  type        = bool
  default     = false
}

variable "blob_delete_retention_days" {
  description = "Specifies the number of days that the deleted blob should be retained. The value must be greater than or equal to 1 if the account has versioning enabled."
  type        = number
  default     = 7
}


variable "network_rules_default_action" {
  description = "The default action of allow or deny when no other rules match."
  type        = string
  default     = "Deny"
}

variable "network_rules_bypass" {
  description = "Specifies whether traffic is bypassed for Logging/Metrics/AzureServices when network access rules are set."
  type        = list(string)
  default     = ["AzureServices"]
}

variable "identity_type" {
  description = "The type of identity used for the Storage Account."
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "A list of identities associated with the Storage Account."
  type        = list(string)
  default     = []
}

variable "cmk" {
  description = "Customer Managed Key configuration for Storage Account."
  type = object({
    kv_id       = string
    kv_key_name = string

  })
  nullable = true
  default  = null
}


variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
