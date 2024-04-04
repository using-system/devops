variable "location" {
  description = "Azure Region Location"
}

variable "resource_group_name" {
  description = "Name of the resource group to create the aks"
}

variable "name" {
  description = "Naming of the aks"
}

variable "configuration" {
  description = "AKS configuration"
  type = object({
    version                         = string
    sku                             = string
    private_cluster                 = bool
    user_assigned_identity_id       = string
    admin_username                  = optional(string)
    local_account_disabled          = optional(bool, true)
    disk_encryption_set_id          = optional(string)
    public_ssh_key                  = optional(string)
    automatic_channel_upgrade       = optional(string)
    kv_key_management_service_id    = optional(string)
    enable_microsoft_defender       = optional(bool, true)
    msi_auth_for_monitoring_enabled = optional(bool, false)
    node_pool = object({
      type                         = string
      count                        = number
      vm_size                      = string
      availability_zones           = list(number)
      os_disk_size                 = number,
      max_pods                     = optional(number, 110)
      temporary_name_for_rotation  = optional(string)
      only_critical_addons_enabled = optional(bool, true)
      upgrade_max_surge            = optional(string, "10%")
    })
    rbac = object({
      enabled                = bool
      admin_group_object_ids = optional(list(string), [])
      tenant_id              = string
    })
    addon = object({
      enable_oms_agent         = optional(bool, false)
      enable_open_service_mesh = bool
      enable_azure_policy      = bool
      service_mesh_profile = optional(object({
        mode                             = string
        external_ingress_gateway_enabled = optional(bool, true)
        internal_ingress_gateway_enabled = optional(bool, false)
      }), null)
    })
    network_profile = object({
      network_plugin    = optional(string, "azure"),
      network_policy    = optional(string, "azure"),
      load_balancer_sku = optional(string, "standard"),
      outbound_type     = optional(string, "userDefinedRouting"),
    })
    monitor_metrics = optional(object({
      annotations_allowed = optional(string)
      labels_allowed      = optional(string)
    }), null)

  })
}

variable "log_analytics_id" {
  description = "Log analytics identifier"
  default     = null
}

variable "subnet_id" {
  description = "Id of the subnet to attach aks nodes"
}

variable "private_dns_zone_id" {
  description = "Id of the private dns zone to attach aks"
  default     = null
}

variable "tags" {
  description = "Tags to associate with resources."
  type        = map(string)
}
