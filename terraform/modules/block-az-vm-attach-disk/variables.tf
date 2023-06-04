variable "name" {
  description = "Disk name"
}

variable "location" {
  description = "Azure Region Location"
}

variable "resource_group_name" {
  description = "Resource group name of the disk"
}

variable "vm_id" {
  description = "Id of the vm to attach the disk to"
}

variable "storage_account_type" {
  description = "Storage account type for the disk"
  default     = "Standard_LRS"
}

variable "create_option" {
  description = "Create option for the disk"
  default     = "Empty"
}

variable "disk_size_gb" {
  description = "Disk size in GB"
  default     = 10
}

variable "lun" {
  description = "Logical unit number for the disk"
  default     = 0
}

variable "caching" {
  description = "Caching for the disk"
  default     = "ReadWrite"
}

variable "public_network_access_enabled" {
  description = "Whether public network access is allowed for this disk"
  default     = false
}

variable "disk_encryption_kv_id" {
  description = "Key Vault Id for disk encryption"
}

variable "identity_ids" {
  description = "List of identity ids to assign to the disk encryption set"
  type        = list(string)
}

variable "encryption_key_expiration_date" {
  description = "Date when the encryption key expires"
  default     = null
}

variable "tags" {
  description = "Tags to associate with resources."
  type        = map(string)
}
