variable "location" {
  description = "Azure Region Location"
}

variable "vm_id" {
  description = "Id of the vm to shutdown"
}

variable "daily_recurrence_time" {
  description = "Time of day to shutdown the vm"
}

variable "timezone" {
  description = "Timezone of the vm"
}
