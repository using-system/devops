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
| [azurerm_dev_test_global_vm_shutdown_schedule.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dev_test_global_vm_shutdown_schedule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_daily_recurrence_time"></a> [daily\_recurrence\_time](#input\_daily\_recurrence\_time) | Time of day to shutdown the vm | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure Region Location | `any` | n/a | yes |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | Timezone of the vm | `any` | n/a | yes |
| <a name="input_vm_id"></a> [vm\_id](#input\_vm\_id) | Id of the vm to shutdown | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->