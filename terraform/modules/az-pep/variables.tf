variable "name" {
  description = "Name of the pep"
}

variable "location" {
  description = "Azure Region Location"
}

variable "resource_group_name" {
  description = "Resource group name of the pep"
}

variable "subnet_id" {
  description = "Id the subnet to use for the pep"
}

variable "private_dns_zone_ids" {
  description = "Ids of the private dns zones to use for the pep"
  type        = list(string)
  default     = []
}

variable "private_connection_resource_id" {
  description = "Id of the resource to connect to"
}

variable "subresource_names" {
  description = "Subresource names to use for the pep"
  type        = list(string)
}

variable "tags" {
  description = "Tags to associate with resources."
  type        = map(string)
}
