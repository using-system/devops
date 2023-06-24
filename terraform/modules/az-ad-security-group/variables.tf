variable "name" {
  description = "Name of the group to create"
}

variable "owners" {
  description = "Owners of the groups"
  type        = list(string)
}
