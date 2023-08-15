variable "algorithm" {
  default = "RSA"
}

variable "rsa_bits" {
  type = optional(string)
}

variable "ecdsa_curve" {
  type = optional(string)
}
