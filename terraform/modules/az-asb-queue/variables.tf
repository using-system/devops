variable "name" {
  description = "The name of the Service Bus Queue"
  type        = string
}

variable "namespace_id" {
  description = "The ID of the Service Bus Namespace"
  type        = string
}

variable "lock_duration" {
  description = "The lock duration for messages in the Service Bus Queue"
  type        = string
  default     = "PT1M"
}

variable "default_message_ttl" {
  description = "The TTL for messages in the Service Bus Queue"
  type        = string
  default     = "PT5M"
}

variable "requires_session" {
  description = "Does the Service Bus Queue require a session"
  type        = bool
  default     = false
}

variable "enable_partitioning" {
  description = "Is partitioning enabled for the Service Bus Queue"
  type        = bool
  default     = false
}

variable "requires_duplicate_detection" {
  description = "Does the Service Bus Queue require duplicate detection"
  type        = bool
  default     = false
}

variable "duplicate_detection_history_time_window" {
  description = "The time window for duplicate detection"
  type        = string
  default     = "PT10M"
}

variable "forward_to" {
  description = "The name of the Service Bus Queue to forward messages to"
  type        = string
  default     = null
}

variable "forward_dead_lettered_messages_to" {
  description = "The name of the Service Bus Queue to forward dead lettered messages to"
  type        = string
  default     = null
}
