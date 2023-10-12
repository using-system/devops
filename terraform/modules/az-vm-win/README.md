<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_network_interface.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_windows_virtual_machine.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |
| [random_password.vm](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | Admin username for the VM | `string` | `"admin"` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | List of identity ids to assign to the vm | `list(string)` | n/a | yes |
| <a name="input_image_offer"></a> [image\_offer](#input\_image\_offer) | Offer for the VM image | `any` | n/a | yes |
| <a name="input_image_publisher"></a> [image\_publisher](#input\_image\_publisher) | Publisher for the VM image | `any` | n/a | yes |
| <a name="input_image_sku"></a> [image\_sku](#input\_image\_sku) | SKU for the VM image | `any` | n/a | yes |
| <a name="input_image_version"></a> [image\_version](#input\_image\_version) | Version for the VM image | `any` | n/a | yes |
| <a name="input_license_type"></a> [license\_type](#input\_license\_type) | License type for the VM | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure Region Location | `any` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | VM name | `any` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name of the vm | `any` | n/a | yes |
| <a name="input_size"></a> [size](#input\_size) | Size of the VM | `any` | n/a | yes |
| <a name="input_storage_account_type"></a> [storage\_account\_type](#input\_storage\_account\_type) | Storage account type for the VM | `any` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Id the subnet to use for the vm | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to associate with resources. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | The admin password of the Windows Virtual Machine |
| <a name="output_admin_username"></a> [admin\_username](#output\_admin\_username) | The admin username of the Windows Virtual Machine |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Windows Virtual Machine |
<!-- END_TF_DOCS -->