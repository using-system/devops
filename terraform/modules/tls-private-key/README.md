<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tls_private_key.key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_algorithm"></a> [algorithm](#input\_algorithm) | n/a | `string` | `"RSA"` | no |
| <a name="input_ecdsa_curve"></a> [ecdsa\_curve](#input\_ecdsa\_curve) | n/a | `string` | `null` | no |
| <a name="input_rsa_bits"></a> [rsa\_bits](#input\_rsa\_bits) | n/a | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Unique identifier for this resource: hexadecimal representation of the SHA1 checksum of the resource |
| <a name="output_private_key_openssh"></a> [private\_key\_openssh](#output\_private\_key\_openssh) | Private key data in OpenSSH PEM (RFC 4716) format |
| <a name="output_private_key_pem"></a> [private\_key\_pem](#output\_private\_key\_pem) | Private key data in PEM (RFC 1421) format |
| <a name="output_private_key_pem_pkcs8"></a> [private\_key\_pem\_pkcs8](#output\_private\_key\_pem\_pkcs8) | Private key data in PKCS#8 PEM (RFC 5208) format |
| <a name="output_public_key_openssh"></a> [public\_key\_openssh](#output\_public\_key\_openssh) | The public key data in Authorized Keys format |
| <a name="output_public_key_pem"></a> [public\_key\_pem](#output\_public\_key\_pem) | Public key data in PEM (RFC 1421) format |
<!-- END_TF_DOCS -->