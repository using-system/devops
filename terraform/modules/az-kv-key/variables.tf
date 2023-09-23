variable "name" {
  description = "The name of the kv customer managed key"
  type        = string
}

variable "kv_id" {
  description = "The ID of the Key Vault in which the Key Vault Key for the customer managed key be created."
  type        = string
}

variable "rotation" {
  description = "The rotation policy of the customer managed key"
  type = object({
    expiration_date                    = optional(string)
    auto_rotatation_time_before_expiry = optional(string, "P30D")
    expire_after                       = optional(string, "P90D")
    notify_before_expiry               = optional(string, "P29D")
  })
}

