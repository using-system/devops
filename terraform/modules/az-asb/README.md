## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.96.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_servicebus_namespace.asb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_capacity"></a> [capacity](#input\_capacity) | The capacity of the Azure Service Bus Namespace | `number` | `1` | no |
| <a name="input_cmk_key_vault_key_id"></a> [cmk\_key\_vault\_key\_id](#input\_cmk\_key\_vault\_key\_id) | The Key Vault Key Id to associate with the Azure Service Bus Namespace | `string` | `null` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | A list of identities associated with the Azure Service Bus Namespace | `list(string)` | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure Region Location | `string` | n/a | yes |
| <a name="input_minimum_tls_version"></a> [minimum\_tls\_version](#input\_minimum\_tls\_version) | The minimum TLS version for the Azure Service Bus Namespace | `string` | `"1.2"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the azure bus namespace | `any` | n/a | yes |
| <a name="input_network_rules_default_action"></a> [network\_rules\_default\_action](#input\_network\_rules\_default\_action) | The default action of the network rules | `string` | `"Deny"` | no |
| <a name="input_premium_messaging_partitions"></a> [premium\_messaging\_partitions](#input\_premium\_messaging\_partitions) | The number of messaging partitions for the Azure Service Bus Namespace | `number` | `1` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Is public network access enabled for the Azure Service Bus Namespace | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name of the azure bus namespace | `any` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU of the Azure Service Bus Namespace | `string` | `"Premium"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | The list of subnet ids to associate with the Azure Service Bus Namespace | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to associate with resources. | `map(string)` | n/a | yes |
| <a name="input_trusted_services_allowed"></a> [trusted\_services\_allowed](#input\_trusted\_services\_allowed) | The list of trusted services allowed | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | The endpoint for the Service Bus Namespace. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Service Bus Namespace. |
