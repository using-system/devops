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
| [azurerm_role_assignment.iam](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_principal_id"></a> [principal\_id](#input\_principal\_id) | ID of the principal to assign the role to, e.g. the object ID of a Service Principal | `string` | n/a | yes |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Name of the role definition to assign, e.g. Reader | `string` | n/a | yes |
| <a name="input_scope"></a> [scope](#input\_scope) | Scope at which the role assignment applies to, e.g. /subscriptions/00000000-0000-0000-0000-000000000000 | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The Role Assignment ID |
| <a name="output_principal_type"></a> [principal\_type](#output\_principal\_type) | The type of the principal\_id, e.g. User, Group, Service Principal, Application, etc |
<!-- END_TF_DOCS -->