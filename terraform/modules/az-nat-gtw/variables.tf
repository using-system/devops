variable "name" {
  type        = string
  description = "Name of the NAT Gateway"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group where the NAT Gateway will be created"
}

variable "location" {
  type        = string
  description = "Location of the NAT Gateway"
}

variable "sku" {
  type        = string
  description = "SKU of the NAT Gateway"
  default     = "Standard"
}

variable "idle_timeout_in_minutes" {
  type        = number
  description = "Idle timeout in minutes"
  default     = 4
}

variable "abailability_zones" {
  type        = list(string)
  description = "Availability zones where the NAT Gateway will be created"
  default     = ["1", "2", "3"]
}

variable "public_ips" {
  type = list(object({
    ip_version         = optional(string, "IPv4")
    prefix_length      = optional(number, 31)
    sku                = optional(string, "Standard")
    abailability_zones = list(string)
  }))
  description = "List of public IPs to be used by the NAT Gateway"
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet where the NAT Gateway will be created"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to the NAT Gateway"
}
