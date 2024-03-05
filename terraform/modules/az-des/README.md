<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name                                                          | Version |
| ------------------------------------------------------------- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.82.0  |

## Modules

No modules.

## Resources

| Name                                                                                                                                   | Type     |
| -------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [azurerm_disk_encryption_set.des](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set) | resource |
| [azurerm_key_vault_key.des](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key)             | resource |
| [azurerm_role_assignment.des](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment)         | resource |

## Inputs

| Name                                                                                                                                       | Description                                                                              | Type          | Default  | Required |
| ------------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------- | ------------- | -------- | :------: |
| <a name="input_auto_rotation_time_before_expiry"></a> [auto\_rotation\_time\_before\_expiry](#input\_auto\_rotation\_time\_before\_expiry) | The time before expiry to automatically rotate the key.                                  | `string`      | `"P7D"`  |    no    |
| <a name="input_expiration_date"></a> [expiration\_date](#input\_expiration\_date)                                                          | The date after which the key expires.                                                    | `string`      | `null`   |    no    |
| <a name="input_identity_id"></a> [identity\_id](#input\_identity\_id)                                                                      | The ID of the identity to assign to the disk encryption set.                             | `string`      | n/a      |   yes    |
| <a name="input_key_size"></a> [key\_size](#input\_key\_size)                                                                               | The size of the key to use for encryption.                                               | `number`      | `4096`   |    no    |
| <a name="input_kv_id"></a> [kv\_id](#input\_kv\_id)                                                                                        | The ID of the Key Vault to use for encryption.                                           | `string`      | n/a      |   yes    |
| <a name="input_location"></a> [location](#input\_location)                                                                                 | The Azure Region in which all resources in this example should be created.               | `string`      | n/a      |   yes    |
| <a name="input_name"></a> [name](#input\_name)                                                                                             | The name of the disk encryption set.                                                     | `string`      | n/a      |   yes    |
| <a name="input_principal_id"></a> [principal\_id](#input\_principal\_id)                                                                   | The ID of the principal to assign to the disk encryption set.                            | `string`      | n/a      |   yes    |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)                                            | The name of the resource group in which all resources in this example should be created. | `string`      | n/a      |   yes    |
| <a name="input_rotation_expire_after"></a> [rotation\_expire\_after](#input\_rotation\_expire\_after)                                      | The time after which the key expires.                                                    | `string`      | `"P30D"` |    no    |
| <a name="input_rotation_notify_before_expiry"></a> [rotation\_notify\_before\_expiry](#input\_rotation\_notify\_before\_expiry)            | The time before expiry to notify that the key is expiring.                               | `string`      | `"P7D"`  |    no    |
| <a name="input_tags"></a> [tags](#input\_tags)                                                                                             | A mapping of tags to assign to the resource.                                             | `map(string)` | n/a      |   yes    |

## Outputs

| Name                                       | Description                       |
| ------------------------------------------ | --------------------------------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Disk Encryption Set |
<!-- END_TF_DOCS -->
