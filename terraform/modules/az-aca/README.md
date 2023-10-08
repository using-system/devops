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
| [azurerm_container_app.aca](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_insecure_connections"></a> [allow\_insecure\_connections](#input\_allow\_insecure\_connections) | Allow insecure connections of the container app | `bool` | `false` | no |
| <a name="input_container_app_environment_id"></a> [container\_app\_environment\_id](#input\_container\_app\_environment\_id) | Id of the container app environment | `any` | n/a | yes |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | CPU of the container app | `number` | `0.25` | no |
| <a name="input_enable_ingress"></a> [enable\_ingress](#input\_enable\_ingress) | Enable ingress of the container app | `bool` | `false` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | Environment variables of the container app | <pre>list(object({<br>    name        = string<br>    value       = optional(string)<br>    secret_name = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_external_enabled"></a> [external\_enabled](#input\_external\_enabled) | External enabled of the container app | `bool` | `false` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | Identity ids of the container app | `list(string)` | `[]` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | Identity type of the container app | `string` | `"SystemAssigned"` | no |
| <a name="input_image"></a> [image](#input\_image) | Image of the container app | `string` | `"mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"` | no |
| <a name="input_max_replicas"></a> [max\_replicas](#input\_max\_replicas) | Max replicas of the container app | `number` | `1` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Memory of the container app | `string` | `"0.5Gi"` | no |
| <a name="input_min_replicas"></a> [min\_replicas](#input\_min\_replicas) | Min replicas of the container app | `number` | `1` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the container app | `any` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name of the aca | `any` | n/a | yes |
| <a name="input_revision_mode"></a> [revision\_mode](#input\_revision\_mode) | Revision of the container app | `string` | `"Single"` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | Secrets of the container app | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to associate with resources. | `map(string)` | n/a | yes |
| <a name="input_target_port"></a> [target\_port](#input\_target\_port) | Target port of the container app | `number` | `80` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->