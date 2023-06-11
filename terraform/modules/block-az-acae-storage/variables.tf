variable "name" {
  type        = string
  description = "The name of the storage share"
}

variable "container_app_environment_id" {
  type        = string
  description = "The ID of the container app environment"
}

variable "storage_account_name" {
  type        = string
  description = "The name of the storage account"
}

variable "storage_share_name" {
  type        = string
  description = "The name of the storage share"
}

variable "storage_account_access_key" {
  type        = string
  description = "The access key of the storage account"
}

variable "access_mode" {
  type        = string
  description = "The access mode of the storage share"
  default     = "ReadWrite"
}
