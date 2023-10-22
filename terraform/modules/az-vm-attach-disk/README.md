<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.77.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_managed_disk.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk) | resource |
| [azurerm_virtual_machine_data_disk_attachment.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_caching"></a> [caching](#input\_caching) | Caching for the disk | `string` | `"ReadWrite"` | no |
| <a name="input_create_option"></a> [create\_option](#input\_create\_option) | Create option for the disk | `string` | `"Empty"` | no |
| <a name="input_des_id"></a> [des\_id](#input\_des\_id) | Id of the disk encryption set to assign to the disk | `any` | `null` | no |
| <a name="input_disk_size_gb"></a> [disk\_size\_gb](#input\_disk\_size\_gb) | Disk size in GB | `number` | `10` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure Region Location | `any` | n/a | yes |
| <a name="input_lun"></a> [lun](#input\_lun) | Logical unit number for the disk | `number` | `0` | no |
| <a name="input_name"></a> [name](#input\_name) | Disk name | `any` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is allowed for this disk | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name of the disk | `any` | n/a | yes |
| <a name="input_storage_account_type"></a> [storage\_account\_type](#input\_storage\_account\_type) | Storage account type for the disk | `string` | `"Standard_LRS"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to associate with resources. | `map(string)` | n/a | yes |
| <a name="input_vm_id"></a> [vm\_id](#input\_vm\_id) | Id of the vm to attach the disk to | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_disk_id"></a> [disk\_id](#output\_disk\_id) | The ID of the disk attached to the Virtual Machine. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Virtual Machine Data Disk attachment. |
<!-- END_TF_DOCS -->