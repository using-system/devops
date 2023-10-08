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
| [azurerm_route_table.network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | Azure Region Location | `any` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name of the vnet | `any` | n/a | yes |
| <a name="input_route_tables"></a> [route\_tables](#input\_route\_tables) | Route tables to create | <pre>list(object({<br>    name                          = string<br>    disable_bgp_route_propagation = bool<br>    routes = list(object({<br>      name                   = string<br>      address_prefix         = string<br>      next_hop_type          = string<br>      next_hop_in_ip_address = optional(string)<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to associate with resources. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rt_ids"></a> [rt\_ids](#output\_rt\_ids) | Map of Route Table names to their respective IDs. |
<!-- END_TF_DOCS -->