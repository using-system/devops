variable "name" {
  description = "Name of the container app"
}

variable "resource_group_name" {
  description = "Resource group name of the aca"
}


variable "container_app_environment_id" {
  description = "Id of the container app environment"
}

variable "revision_mode" {
  description = "Revision of the container app"
  type        = string
  default     = "Single"
}

variable "image" {
  description = "Image of the container app"
  type        = string
  default     = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
}

variable "cpu" {
  description = "CPU of the container app"
  type        = number
  default     = 0.25
}

variable "memory" {
  description = "Memory of the container app"
  type        = string
  default     = "0.5Gi"
}

variable "min_replicas" {
  description = "Min replicas of the container app"
  type        = number
  default     = 1
}

variable "max_replicas" {
  description = "Max replicas of the container app"
  type        = number
  default     = 1
}

variable "environment_variables" {
  description = "Environment variables of the container app"
  type = list(object({
    name        = string
    value       = string
    secret_name = string
  }))
  default = []
}

variable "identity_type" {
  description = "Identity type of the container app"
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "Identity ids of the container app"
  type        = list(string)
  default     = []
}

variable "enable_ingress" {
  description = "Enable ingress of the container app"
  type        = bool
  default     = false
}

variable "allow_insecure_connections" {
  description = "Allow insecure connections of the container app"
  type        = bool
  default     = false
}

variable "external_enabled" {
  description = "External enabled of the container app"
  type        = bool
  default     = false
}
