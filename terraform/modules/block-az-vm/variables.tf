variable "location" {
  description = "Azure Region Location"
}

variable "resource_group_name" {
  description = "Resource group name of the vm"
}

variable "name" {
  description = "VM name"
}

variable "subnet_id" {
  description = "Id the subnet to use for the vm"
}

variable "size" {
  description = "Size of the VM"
}

variable "admin_username" {
  description = "Admin username for the VM"
  default     = "admin"
}

variable "license_type" {
  description = "License type for the VM"
}

variable "storage_account_type" {
  description = "Storage account type for the VM"
}

variable "image_publisher" {
  description = "Publisher for the VM image"
}

variable "image_offer" {
  description = "Offer for the VM image"
}

variable "image_sku" {
  description = "SKU for the VM image"
}

variable "image_version" {
  description = "Version for the VM image"
}
variable "tags" {
  description = "Tags to associate with resources."
  type        = map(string)
}
