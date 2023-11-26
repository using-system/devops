<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.82.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |
| [azurerm_management_lock.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_enabled"></a> [admin\_enabled](#input\_admin\_enabled) | Determines if the admin user is enabled | `bool` | `false` | no |
| <a name="input_enable_lock_on_acr"></a> [enable\_lock\_on\_acr](#input\_enable\_lock\_on\_acr) | Determines if the lock on acr is enabled | `bool` | `true` | no |
| <a name="input_georeplication_locations"></a> [georeplication\_locations](#input\_georeplication\_locations) | List of locations for the georeplication | `list(string)` | `[]` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | A list of identities associated with the acr. | `list(string)` | `[]` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | The type of identity used for the acr. | `string` | `"SystemAssigned"` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure Region Location | `any` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the acr | `any` | n/a | yes |
| <a name="input_network_rule_bypass_option"></a> [network\_rule\_bypass\_option](#input\_network\_rule\_bypass\_option) | Determines if the network rule bypass option is enabled | `string` | `"None"` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Determines if the public network access is enabled | `bool` | `false` | no |
| <a name="input_quarantine_policy_enabled"></a> [quarantine\_policy\_enabled](#input\_quarantine\_policy\_enabled) | Determines if the quarantine policy is enabled | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name of the acr | `any` | n/a | yes |
| <a name="input_retention_policy_days"></a> [retention\_policy\_days](#input\_retention\_policy\_days) | Number of days to retain an untagged manifest after which it gets purged | `number` | `7` | no |
| <a name="input_retention_policy_enabled"></a> [retention\_policy\_enabled](#input\_retention\_policy\_enabled) | Determines if the retention policy is enabled | `bool` | `true` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU name of the container registry. | `string` | `"Premium"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to associate with resources. | `map(string)` | n/a | yes |
| <a name="input_trust_policy_enabled"></a> [trust\_policy\_enabled](#input\_trust\_policy\_enabled) | Determines if the trust policy is enabled | `bool` | `true` | no |
| <a name="input_zone_redundancy_enabled"></a> [zone\_redundancy\_enabled](#input\_zone\_redundancy\_enabled) | Determines if the zone redundancy is enabled | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | The Username associated with the Container Registry Admin account - if the admin account is enabled |
| <a name="output_admin_username"></a> [admin\_username](#output\_admin\_username) | The Username associated with the Container Registry Admin account - if the admin account is enabled |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Container Registry |
| <a name="output_login_server"></a> [login\_server](#output\_login\_server) | The URL that can be used to log into the container registry |
<!-- END_TF_DOCS -->