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
| [azurerm_storage_account.storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_account_customer_managed_key.storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_customer_managed_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | Defines the type of replication to use for this storage account. | `string` | `"GRS"` | no |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | Defines the Tier to use for this storage account. | `string` | `"Standard"` | no |
| <a name="input_allow_nested_items_to_be_public"></a> [allow\_nested\_items\_to\_be\_public](#input\_allow\_nested\_items\_to\_be\_public) | Specifies whether or not public access is allowed on the blobs within the container. | `bool` | `false` | no |
| <a name="input_blob_delete_retention_days"></a> [blob\_delete\_retention\_days](#input\_blob\_delete\_retention\_days) | Specifies the number of days that the deleted blob should be retained. The value must be greater than or equal to 1 if the account has versioning enabled. | `number` | `7` | no |
| <a name="input_enable_https_traffic_only"></a> [enable\_https\_traffic\_only](#input\_enable\_https\_traffic\_only) | Enables https traffic only to storage service if set to true. | `bool` | `true` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | A list of identities associated with the Storage Account. | `list(string)` | `[]` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | The type of identity used for the Storage Account. | `string` | `"SystemAssigned"` | no |
| <a name="input_kv_id_cust_managed_key"></a> [kv\_id\_cust\_managed\_key](#input\_kv\_id\_cust\_managed\_key) | The ID of the Key Vault containing the key to be used as the Customer Managed Key for the Storage Account. | `string` | n/a | yes |
| <a name="input_kv_key_name_cust_managed_key"></a> [kv\_key\_name\_cust\_managed\_key](#input\_kv\_key\_name\_cust\_managed\_key) | The name of the Key Vault Key to be used as the Customer Managed Key for the Storage Account. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location of the resource group in which to create the storage account. | `string` | n/a | yes |
| <a name="input_min_tls_version"></a> [min\_tls\_version](#input\_min\_tls\_version) | The minimum supported TLS version for the storage account. | `string` | `"TLS1_2"` | no |
| <a name="input_name"></a> [name](#input\_name) | Specifies the name of the storage account. | `string` | n/a | yes |
| <a name="input_network_rules_bypass"></a> [network\_rules\_bypass](#input\_network\_rules\_bypass) | Specifies whether traffic is bypassed for Logging/Metrics/AzureServices when network access rules are set. | `list(string)` | <pre>[<br>  "AzureServices"<br>]</pre> | no |
| <a name="input_network_rules_default_action"></a> [network\_rules\_default\_action](#input\_network\_rules\_default\_action) | The default action of allow or deny when no other rules match. | `string` | `"Deny"` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Specifies whether or not public network access is allowed for the storage account. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the storage account. | `string` | n/a | yes |
| <a name="input_shared_access_key_enabled"></a> [shared\_access\_key\_enabled](#input\_shared\_access\_key\_enabled) | Specifies whether the storage account permits requests to be authorized with the account access key via Shared Key. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | n/a |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | n/a |
| <a name="output_secondary_access_key"></a> [secondary\_access\_key](#output\_secondary\_access\_key) | n/a |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | n/a |
<!-- END_TF_DOCS -->