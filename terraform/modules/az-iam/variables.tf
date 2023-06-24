variable "scope" {
  description = "Scope at which the role assignment applies to, e.g. /subscriptions/00000000-0000-0000-0000-000000000000"
  type        = string
}

variable "role_name" {
  description = "Name of the role definition to assign, e.g. Reader"
  type        = string
}

variable "principal_id" {
  description = "ID of the principal to assign the role to, e.g. the object ID of a Service Principal"
  type        = string
}
