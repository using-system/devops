variable "name" {
  description = "Name of the container app environment"
  type        = string
}

variable "location" {
  description = "Azure Region Location"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name of the acae"
  type        = string
}

variable "subnet_id" {
  description = "Id the subnet to use for the acae"
  type        = string
  default     = null
}

variable "internal_load_balancer_enabled" {
  description = "Determines if the load balancer is internal or external"
  type        = bool
  default     = null
}

variable "log_analytics_workspace_id" {
  description = "Id of the log analytics workspace to use for the acae"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to associate with resources."
  type        = map(string)
}
