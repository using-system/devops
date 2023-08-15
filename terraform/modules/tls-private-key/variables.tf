variable "algorithm" {
  default = "RSA"
}

variable "rsa_bits" {
  type    = string
  default = null
}

variable "ecdsa_curve" {
  type    = string
  default = null
}
