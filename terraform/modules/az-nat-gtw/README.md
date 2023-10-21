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
| [azurerm_nat_gateway.nat_gtw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway) | resource |
| [azurerm_nat_gateway_public_ip_association.nat_gtw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway_public_ip_association) | resource |
| [azurerm_public_ip.nat_gtw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_subnet_nat_gateway_association.nat_gtw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Availability zones where the NAT Gateway will be created | `list(string)` | n/a | yes |
| <a name="input_idle_timeout_in_minutes"></a> [idle\_timeout\_in\_minutes](#input\_idle\_timeout\_in\_minutes) | Idle timeout in minutes | `number` | `4` | no |
| <a name="input_location"></a> [location](#input\_location) | Location of the NAT Gateway | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the NAT Gateway | `string` | n/a | yes |
| <a name="input_public_ips"></a> [public\_ips](#input\_public\_ips) | List of public IPs to be used by the NAT Gateway | <pre>list(object({<br>    ip_version         = optional(string, "IPv4")<br>    sku                = optional(string, "Standard")<br>    availability_zones = list(string)<br>  }))</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group where the NAT Gateway will be created | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | SKU of the NAT Gateway | `string` | `"Standard"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | IDs of the subnets where the NAT Gateway will be associated with | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to the NAT Gateway | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The nat gateway ID. |
| <a name="output_resource_guid"></a> [resource\_guid](#output\_resource\_guid) | The resource guid of the nat gateway. |
<!-- END_TF_DOCS -->