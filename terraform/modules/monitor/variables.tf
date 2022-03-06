variable location {
  description = "Azure Region Location"
}

variable naming {
  description = "Naming for prefix for resources"
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