variable "group_object_id" {
  description = "Object id of the group"
  type        = string
}

variable "members" {
  description = "Principals names to add to the group"
  type        = list(string)
}
