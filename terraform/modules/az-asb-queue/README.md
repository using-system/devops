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
| [azurerm_servicebus_queue.asb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_queue) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_message_ttl"></a> [default\_message\_ttl](#input\_default\_message\_ttl) | The TTL for messages in the Service Bus Queue | `string` | `"PT5M"` | no |
| <a name="input_duplicate_detection_history_time_window"></a> [duplicate\_detection\_history\_time\_window](#input\_duplicate\_detection\_history\_time\_window) | The time window for duplicate detection | `string` | `"PT10M"` | no |
| <a name="input_enable_partitioning"></a> [enable\_partitioning](#input\_enable\_partitioning) | Is partitioning enabled for the Service Bus Queue | `bool` | `false` | no |
| <a name="input_forward_dead_lettered_messages_to"></a> [forward\_dead\_lettered\_messages\_to](#input\_forward\_dead\_lettered\_messages\_to) | The name of the Service Bus Queue to forward dead lettered messages to | `string` | `""` | no |
| <a name="input_forward_to"></a> [forward\_to](#input\_forward\_to) | The name of the Service Bus Queue to forward messages to | `string` | `""` | no |
| <a name="input_lock_duration"></a> [lock\_duration](#input\_lock\_duration) | The lock duration for messages in the Service Bus Queue | `string` | `"PT1M"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Service Bus Queue | `string` | n/a | yes |
| <a name="input_namespace_id"></a> [namespace\_id](#input\_namespace\_id) | The ID of the Service Bus Namespace | `string` | n/a | yes |
| <a name="input_requires_duplicate_detection"></a> [requires\_duplicate\_detection](#input\_requires\_duplicate\_detection) | Does the Service Bus Queue require duplicate detection | `bool` | `false` | no |
| <a name="input_requires_session"></a> [requires\_session](#input\_requires\_session) | Does the Service Bus Queue require a session | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ServiceBus Queue ID. |
