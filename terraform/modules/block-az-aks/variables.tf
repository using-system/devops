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
    admin_public_ssh_key      = string
    node_pool = object({
      type               = string
      count              = number
      vm_size            = string
      availability_zones = list(number)
      os_disk_type       = string
      os_disk_size       = number
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

variable "tags" {
  description = "Tags to associate with resources."
  type        = map(string)
}
