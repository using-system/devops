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

variable "key_vault_id" {
  description = "The ID of the Key Vault in which the Key Vault Key for the Disk Encryption Set should be created."
  type        = string
}

variable "identity_ids" {
  description = "A list of User Assigned Identity IDs to assign to the Disk Encryption Set."
  type        = list(string)
}

variable "expiration_date" {
  description = "The expiration date of the Key Vault Key."
  type        = string
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}
