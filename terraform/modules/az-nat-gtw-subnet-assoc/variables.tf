variable "nat_gateway_id" {
  type        = string
  description = "ID of the NAT Gateway to be associated with the subnets"
}

variable "subnet_ids" {
  type        = list(string)
  description = "IDs of the subnets where the NAT Gateway will be associated with"
}
