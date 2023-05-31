variable "location" {
  description = "Azure Region Location"
}

variable "resource_group_name" {
  description = "Name of the resource group to create the aks"
}

variable "name" {
  description = "Naming of the aks"
}

variable "subscription_id" {
  description = "Azure Subscription Identifier"
}

variable "configuration" {
  description = "AKS configuration"
  type = object({
    version                   = string
    sku                       = string
    private_cluster           = bool
    user_assigned_identity_id = string
    admin_username            = string
    disk_encryption_set_id    = optional(string)
    public_ssh_key            = optional(string)
    node_pool = object({
      type               = string
      count              = number
      vm_size            = string
      availability_zones = list(number)
      os_disk_type       = string
      os_disk_size       = number

    })
    rbac = object({
      enabled                = bool
      admin_group_object_ids = list(string)
      tenant_id              = string
    })
    addon = object({
      enable_open_service_mesh = bool
      enable_azure_policy      = bool
    })

  })
}

variable "log_analytics_id" {
  description = "Log analytics identifier"
}

variable "subnet_id" {
  description = "Id of the subnet to attach aks nodes"
}

variable "prevent_destroy" {
  description = "Prevent destroy of the aks"
  default     = false
}

variable "tags" {
  description = "Tags to associate with resources."
  type        = map(string)
}
