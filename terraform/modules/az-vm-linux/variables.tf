variable "resource_group_name" {
  description = "The name of the resource group in which to create the linux vm."
  type        = string
}

variable "location" {
  description = "The location/region where the linux vm will be created."
  type        = string
}

variable "name" {
  description = "The name of the linux vm."
  type        = string
}

variable "size" {
  description = "The size of the linux vm."
  type        = string
}

variable "admin_username" {
  description = "The admin username of the linux vm."
  type        = string
}

variable "subnet_id" {
  description = "The subnet id of the linux vm."
  type        = string
}

variable "storage_account_type" {
  description = "The storage account type of the linux vm."
  type        = string
  default     = "Standard_LRS"
}

variable "image" {
  description = "The image of the linux vm."
  type = {
    publisher = string
    offer     = string
    sku       = string
    version   = string
  }
}

variable "tags" {
  description = "The tags of the linux vm."
  type        = map(string)
}
