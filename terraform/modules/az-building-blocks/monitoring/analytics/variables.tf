variable location {
  description = "Azure Region Location"
}

variable resource_group_name {
  description = "Resource group name of the analytics"
}


variable configuration {
  description   = "Azure Monitor configuration"
  type          = object({
    sku                         = string
    retention_in_days           = number
  })  
}

variable tags {
  description = "Tags to associate with resources."
  type        = map(string)
}