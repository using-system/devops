variable "name" {
  description = "The name of the kv customer managed key"
  type        = string
}

variable "kv_id" {
  description = "The ID of the Key Vault in which the Key Vault Key for the customer managed key be created."
  type        = string
}


variable "expiration_date" {
  description = "The expiration date of the Key Vault Key."
  default     = null
}
