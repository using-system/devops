variables {
    algorithm    = "RSA"
    rsa_bits     = 4096
}

run "plan" {

  command = plan

  assert {
    condition     = tls_private_key.key.algorithm == var.algorithm
    error_message = "tls_private_key algorithm must be set"
  }

  assert {
    condition     = tls_private_key.key.rsa_bits == var.rsa_bits
    error_message = "tls_private_key rsa_bits must be set"
  }
}

run "apply" {

  command = apply

  assert {
    condition       = output.public_key_openssh != "" && output.public_key_openssh != null
    error_message  = "output public_key_openssh is empty"
  }

  assert {
    condition       = output.private_key_openssh != "" && output.private_key_openssh != null
    error_message  = "output private_key_openssh is empty"
  }

}