variable "name" {
  description = "Name of the container app environment."
}

variable "location" {
  description = "Azure Region Location"
}

variable "resource_group_name" {
  description = "Resource group name of the acae"
}

variable "subnet_id" {
  description = "Id the subnet to use for the acae"
}

variable "internal_load_balancer_enabled" {
  description = "Determines if the load balancer is internal or external"
  type        = bool
}

variable "log_analytics_workspace_id" {
  description = "Id of the log analytics workspace to use for the acae"
}

variable "tags" {
  description = "Tags to associate with resources."
  type        = map(string)
}
