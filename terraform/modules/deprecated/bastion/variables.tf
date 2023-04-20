variable location {
  description = "Azure Region Location"
}

variable naming {
  description = "Naming for prefix for resources"
}

variable subnet_id {
  description = "Id of the subnet to attach aks nodes"
}

variable tags {
  description = "Tags to associate with resources."
  type        = map(string)
}