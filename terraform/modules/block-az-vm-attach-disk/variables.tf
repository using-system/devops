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

variable "tags" {
  description = "Tags to associate with resources."
  type        = map(string)
}
