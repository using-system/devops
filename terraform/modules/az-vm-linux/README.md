<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.78.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | The admin username of the linux vm. | `string` | n/a | yes |
| <a name="input_allow_extension_operations"></a> [allow\_extension\_operations](#input\_allow\_extension\_operations) | Allow extension operations on the linux vm. | `bool` | `false` | no |
| <a name="input_disk_encryption_set_id"></a> [disk\_encryption\_set\_id](#input\_disk\_encryption\_set\_id) | The disk encryption set id of the linux vm. | `string` | n/a | yes |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | List of identity ids to assign to the vm | `list(string)` | n/a | yes |
| <a name="input_image"></a> [image](#input\_image) | The image of the linux vm. | <pre>object({<br>    publisher = string<br>    offer     = string<br>    sku       = string<br>    version   = string<br>  })</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location/region where the linux vm will be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the linux vm. | `string` | n/a | yes |
| <a name="input_public_key_openssh"></a> [public\_key\_openssh](#input\_public\_key\_openssh) | The public key of the linux vm in OpenSSH format. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the linux vm. | `string` | n/a | yes |
| <a name="input_size"></a> [size](#input\_size) | The size of the linux vm. | `string` | n/a | yes |
| <a name="input_storage_account_type"></a> [storage\_account\_type](#input\_storage\_account\_type) | The storage account type of the linux vm. | `string` | `"Standard_LRS"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The subnet id of the linux vm. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags of the linux vm. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Linux Virtual Machine |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | The private IP address of the Linux Virtual Machine |
<!-- END_TF_DOCS -->