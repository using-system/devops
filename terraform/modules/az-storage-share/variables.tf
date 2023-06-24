variable "name" {
  type        = string
  description = "The name of the storage share"
}

variable "storage_account_name" {
  type        = string
  description = "The name of the storage account"
}

variable "quota" {
  type        = number
  description = "The quota of the storage share"
}
