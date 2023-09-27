variable "name" {
  description = "The name of the kv customer key"
  type        = string
}

variable "kv_id" {
  description = "The ID of the Key Vault in which the Key Vault Key for the ctomer managed key be created."
  type        = string
}

variable "key_size" {
  description = "The size of the key to create in the Key Vault."
  type        = number
  default     = 4096
}

variable "rotation" {
  description = "The rotation policy of the managed key"
  type = object({
    auto_rotatation_time_before_expiry = optional(string, "P30D")
    expire_after                       = optional(string, "P90D")
    notify_before_expiry               = optional(string, "P29D")
  })
}

variable "static_expiration_date" {
  description = "The static expiration date of the managed key"
  type        = string
  default     = null
}

