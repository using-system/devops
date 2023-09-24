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

variable "expiration_date" {
  description = "The date after which the key expires."
  type        = string
  default     = null
}

variable "identity_ids" {
  description = "A list of User Assigned Identity IDs to assign to the Disk Encryption Set."
  type        = list(string)
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}
