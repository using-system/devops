variable "name" {
  description = "Name of the identity"
}

variable "location" {
  description = "Azure Region Location"
}


variable "resource_group_name" {
  description = "Resource group name of the identiy"
}

variable "tags" {
  description = "Tags to associate with resources."
  type        = map(string)
}
