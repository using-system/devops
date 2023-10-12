<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_key.key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_key_size"></a> [key\_size](#input\_key\_size) | The size of the key to create in the Key Vault. | `number` | `4096` | no |
| <a name="input_kv_id"></a> [kv\_id](#input\_kv\_id) | The ID of the Key Vault in which the Key Vault Key for the ctomer managed key be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the kv customer key | `string` | n/a | yes |
| <a name="input_rotation"></a> [rotation](#input\_rotation) | The rotation policy of the managed key | <pre>object({<br>    auto_rotatation_time_before_expiry = optional(string, "P30D")<br>    expire_after                       = optional(string, "P90D")<br>    notify_before_expiry               = optional(string, "P29D")<br>  })</pre> | `null` | no |
| <a name="input_static_expiration_date"></a> [static\_expiration\_date](#input\_static\_expiration\_date) | The static expiration date of the managed key | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Key Vault Key. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Key Vault Key. |
| <a name="output_public_key_openssh"></a> [public\_key\_openssh](#output\_public\_key\_openssh) | The public key of the Key Vault Key in OpenSSH format. |
| <a name="output_public_key_pem"></a> [public\_key\_pem](#output\_public\_key\_pem) | The public key of the Key Vault Key in PEM format. |
<!-- END_TF_DOCS -->