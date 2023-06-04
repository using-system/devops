variable "kv_id" {
  description = "The key vault id"
  type        = string
}

variable "secret_name" {
  description = "The secret name"
  type        = string
}

variable "secret_value" {
  description = "The secret value"
  type        = string
}

variable "content_type" {
  description = "The content type"
  type        = string
  default     = "text/plain"
}

variable "expiration_date" {
  description = "The expiration date"
  type        = string
  default     = null
}
