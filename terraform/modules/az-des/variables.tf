variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which all resources in this example should be created."
  type        = string
}

variable "name" {
  description = "The name of the disk encryption set."
  type        = string
}

variable "kv_id" {
  description = "The ID of the Key Vault to use for encryption."
  type        = string
}

variable "key_size" {
  description = "The size of the key to use for encryption."
  type        = number
  default     = 4096
}

variable "auto_rotation_time_before_expiry" {
  description = "The time before expiry to automatically rotate the key."
  type        = string
  default     = "P7D"
}

variable "rotation_expire_after" {
  description = "The time after which the key expires."
  type        = string
  default     = "P30D"
}

variable "rotation_notify_before_expiry" {
  description = "The time before expiry to notify that the key is expiring."
  type        = string
  default     = "P7D"
}

variable "expiration_date" {
  description = "The date after which the key expires."
  type        = string
  default     = null
}

variable "identity_id" {
  description = "The ID of the identity to assign to the disk encryption set."
  type        = string
}

variable "principal_id" {
  description = "The ID of the principal to assign to the disk encryption set."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}
