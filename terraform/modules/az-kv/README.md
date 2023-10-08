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
| [azurerm_key_vault.keyvault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_monitor_diagnostic_setting.keyvault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_rbac_authorization"></a> [enable\_rbac\_authorization](#input\_enable\_rbac\_authorization) | value to enable RBAC authorization for the Key Vault. | `bool` | `true` | no |
| <a name="input_enabled_for_disk_encryption"></a> [enabled\_for\_disk\_encryption](#input\_enabled\_for\_disk\_encryption) | Specifies if Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. | `bool` | `false` | no |
| <a name="input_enabled_for_template_deployment"></a> [enabled\_for\_template\_deployment](#input\_enabled\_for\_template\_deployment) | Specifies if Azure Resource Manager is permitted to retrieve secrets from the vault. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure location where the Key Vault should be created. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | Log analytics workspace id where to save diag audit event | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Key Vault. | `string` | n/a | yes |
| <a name="input_network_rules_bypass"></a> [network\_rules\_bypass](#input\_network\_rules\_bypass) | Specifies which traffic can bypass the network rules. Possible values are AzureServices and None. | `string` | `"AzureServices"` | no |
| <a name="input_network_rules_default_action"></a> [network\_rules\_default\_action](#input\_network\_rules\_default\_action) | The Default Action to use when no rules match from ip\_rules / virtual\_network\_subnet\_ids. Possible values are Allow and Deny | `string` | `"Allow"` | no |
| <a name="input_network_subnet_ids"></a> [network\_subnet\_ids](#input\_network\_subnet\_ids) | One or more Subnet IDs which should be able to access this Key Vault. | `list(string)` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether or not public network access is allowed for the key vault. | `bool` | `false` | no |
| <a name="input_purge_protection_enabled"></a> [purge\_protection\_enabled](#input\_purge\_protection\_enabled) | Specifies if Purge Protection should be enabled for this Key Vault. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the Key Vault. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | The name of the SKU for the Key Vault. | `string` | `"standard"` | no |
| <a name="input_soft_delete_retention_days"></a> [soft\_delete\_retention\_days](#input\_soft\_delete\_retention\_days) | The number of days that items should be retained for once soft-deleted. | `number` | `7` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to associate with resources. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the created Azure Key Vault. |
| <a name="output_uri"></a> [uri](#output\_uri) | The URI of the created Azure Key Vault. |
<!-- END_TF_DOCS -->