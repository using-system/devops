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
| [azurerm_log_analytics_workspace.monitoring](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_configuration"></a> [configuration](#input\_configuration) | Azure Monitor configuration | <pre>object({<br>    sku                        = string<br>    retention_in_days          = number<br>    internet_ingestion_enabled = bool<br>    internet_query_enabled     = bool<br>  })</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure Region Location | `any` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the analytics | `any` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name of the analytics | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to associate with resources. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The Log Analytics Workspace ID |
| <a name="output_primary_shared_key"></a> [primary\_shared\_key](#output\_primary\_shared\_key) | The Primary shared key for the Log Analytics Workspace |
| <a name="output_secondary_shared_key"></a> [secondary\_shared\_key](#output\_secondary\_shared\_key) | The Secondary  shared key for the Log Analytics Workspace |
| <a name="output_workspace_id"></a> [workspace\_id](#output\_workspace\_id) | The Workspace (or Customer) ID for the Log Analytics Workspace |
<!-- END_TF_DOCS -->