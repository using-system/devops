resource "azurerm_servicebus_queue" "asb" {
  name         = var.name
  namespace_id = var.namespace_id

  lock_duration                           = var.lock_duration
  default_message_ttl                     = var.default_message_ttl
  requires_session                        = var.requires_session
  enable_partitioning                     = var.enable_partitioning
  requires_duplicate_detection            = var.requires_duplicate_detection
  duplicate_detection_history_time_window = var.duplicate_detection_history_time_window

  forward_to                        = var.forward_to
  forward_dead_lettered_messages_to = var.forward_dead_lettered_messages_to

}
