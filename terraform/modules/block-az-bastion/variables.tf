variable "location" {
  description = "Azure Region Location"
}

variable "resource_group_name" {
  description = "Name of the resource group to create"
}

variable "name" {
  description = "Name of the bastion host"
}

variable "subnet_id" {
  description = "Id of the subnet to deploy the bastion host"
}

variable "copy_paste_enabled" {
  description = "Enable copy/paste"
  default     = true
}

variable "file_copy_enabled" {
  description = "Enable file copy"
  default     = false
}

variable "scale_units" {
  description = "Number of scale units"
  default     = 2
}


variable "ip_connect_enabled" {
  description = "Enable IP connect"
  default     = false
}

variable "tags" {
  description = "Tags to apply to the bastion host"
  default     = {}
}
