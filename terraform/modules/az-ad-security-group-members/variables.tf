variable "group_object_id" {
  description = "Object id of the group"
  type        = string
}

variable "members" {
  description = "Objects ids to add to the group"
  type        = list(string)
}
