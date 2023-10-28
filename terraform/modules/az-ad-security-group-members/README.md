<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.45.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_group_member.aad_group_members](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_group_object_id"></a> [group\_object\_id](#input\_group\_object\_id) | Object id of the group | `string` | n/a | yes |
| <a name="input_members"></a> [members](#input\_members) | Objects ids to add to the group | `list(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->