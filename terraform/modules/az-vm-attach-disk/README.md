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
| [azurerm_disk_encryption_set.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set) | resource |
| [azurerm_key_vault_key.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_managed_disk.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk) | resource |
| [azurerm_virtual_machine_data_disk_attachment.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_caching"></a> [caching](#input\_caching) | Caching for the disk | `string` | `"ReadWrite"` | no |
| <a name="input_create_option"></a> [create\_option](#input\_create\_option) | Create option for the disk | `string` | `"Empty"` | no |
| <a name="input_disk_encryption_kv_id"></a> [disk\_encryption\_kv\_id](#input\_disk\_encryption\_kv\_id) | Key Vault Id for disk encryption | `any` | n/a | yes |
| <a name="input_disk_size_gb"></a> [disk\_size\_gb](#input\_disk\_size\_gb) | Disk size in GB | `number` | `10` | no |
| <a name="input_encryption_key_expiration_date"></a> [encryption\_key\_expiration\_date](#input\_encryption\_key\_expiration\_date) | Date when the encryption key expires | `any` | `null` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | List of identity ids to assign to the disk encryption set | `list(string)` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure Region Location | `any` | n/a | yes |
| <a name="input_lun"></a> [lun](#input\_lun) | Logical unit number for the disk | `number` | `0` | no |
| <a name="input_name"></a> [name](#input\_name) | Disk name | `any` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is allowed for this disk | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name of the disk | `any` | n/a | yes |
| <a name="input_storage_account_type"></a> [storage\_account\_type](#input\_storage\_account\_type) | Storage account type for the disk | `string` | `"Standard_LRS"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to associate with resources. | `map(string)` | n/a | yes |
| <a name="input_vm_id"></a> [vm\_id](#input\_vm\_id) | Id of the vm to attach the disk to | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->