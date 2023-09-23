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

variable "public_key_openssh" {
  description = "The public key of the linux vm in OpenSSH format."
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
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}

variable "identity_ids" {
  description = "List of identity ids to assign to the vm"
  type        = list(string)
}

variable "allow_extension_operations" {
  description = "Allow extension operations on the linux vm."
  type        = bool
  default     = false
}

variable "tags" {
  description = "The tags of the linux vm."
  type        = map(string)
}
