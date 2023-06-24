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

variable "kv_key_id_cust_managed_key" {
  description = "The ID of the Key Vault Key to be used as the Customer Managed Key for the Storage Account."
  type        = string
}

variable "identity_ids" {
  description = "A list of User Assigned Identity IDs to assign to the Disk Encryption Set."
  type        = list(string)
}

variable "expiration_date" {
  description = "The expiration date of the Key Vault Key."
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}
