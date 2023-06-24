variable "name" {
  description = "he name of the DNS Zone"
}
variable "resource_group_name" {
  description = "Resource group name of the dns zone"
}

variable "tags" {
  description = "Tags to associate with resources."
  type        = map(string)
}
