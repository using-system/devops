variable "location" {
  description = "Azure Region Location"
}

variable "name" {
  description = "Naming for prefix for resources"
}

variable "tags" {
  description = "Tags to associate with resources."
  type        = map(string)
}
