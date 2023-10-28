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
| [azurerm_network_security_group.network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | Azure Region Location | `any` | n/a | yes |
| <a name="input_network_security_groups"></a> [network\_security\_groups](#input\_network\_security\_groups) | Network security groups to create | <pre>list(object({<br>    name = string<br>    rules = list(object({<br>      name                       = string<br>      priority                   = string<br>      direction                  = string<br>      access                     = string<br>      protocol                   = string<br>      source_address_prefix      = string<br>      source_port_range          = string<br>      destination_address_prefix = string<br>      destination_port_range     = string<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name of the vnet | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to associate with resources. | `map(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->