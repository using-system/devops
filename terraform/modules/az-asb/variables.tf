variable "name" {
  description = "Name of the azure bus namespace"
}

variable "location" {
  description = "Azure Region Location"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name of the azure bus namespace"
}

variable "sku" {
  description = "The SKU of the Azure Service Bus Namespace"
  type        = string
  default     = "Premium"
}

variable "capacity" {
  description = "The capacity of the Azure Service Bus Namespace"
  type        = number
  default     = 1
}

variable "premium_messaging_partitions" {
  description = "The number of messaging partitions for the Azure Service Bus Namespace"
  type        = number
  default     = 1
}

variable "public_network_access_enabled" {
  description = "Is public network access enabled for the Azure Service Bus Namespace"
  type        = bool
  default     = false
}

variable "subnet_ids" {
  description = "The list of subnet ids to associate with the Azure Service Bus Namespace"
  type        = list(string)
  default     = []
}

variable "network_rules_default_action" {
  description = "The default action of the network rules"
  type        = string
  default     = "Deny"
}

variable "trusted_services_allowed" {
  description = "The list of trusted services allowed"
  type        = bool
  default     = false
}

variable "identity_ids" {
  description = "A list of identities associated with the Azure Service Bus Namespace"
  type        = list(string)
  default     = []
}

variable "cmk_key_vault_key_id" {
  description = "The Key Vault Key Id to associate with the Azure Service Bus Namespace"
  type        = string
  default     = null
}

variable "minimum_tls_version" {
  description = "The minimum TLS version for the Azure Service Bus Namespace"
  type        = string
  default     = "1.2"
}

variable "tags" {
  description = "Tags to associate with resources."
  type        = map(string)
}
