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
| [azurerm_key_vault_secret.keyvault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_content_type"></a> [content\_type](#input\_content\_type) | The content type | `string` | `"text/plain"` | no |
| <a name="input_expiration_date"></a> [expiration\_date](#input\_expiration\_date) | The expiration date | `string` | `null` | no |
| <a name="input_kv_id"></a> [kv\_id](#input\_kv\_id) | The key vault id | `string` | n/a | yes |
| <a name="input_secret_name"></a> [secret\_name](#input\_secret\_name) | The secret name | `string` | n/a | yes |
| <a name="input_secret_value"></a> [secret\_value](#input\_secret\_value) | The secret value | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The Key Vault Secret ID |
<!-- END_TF_DOCS -->