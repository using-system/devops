provider "azurerm" {
  features {
  }
}

run "setup" {
  module {
    source = "./tests/setup"
  }
}

run "plan" {

  command = plan

  variables {
    name                            = "azasbstandardqueue"
    namespace_id                    = run.setup.namespace_id
    default_message_ttl             = "PT1M"
  }

  assert {
    condition      = azurerm_servicebus_queue.asb.name == var.name
    error_message  = "azurerm_servicebus_queue name must be set"
  }

  assert {
    condition      = azurerm_servicebus_queue.asb.namespace_id == var.namespace_id
    error_message  = "azurerm_servicebus_queue namespace_id must be set"
  }

  assert {
    condition      = azurerm_servicebus_queue.asb.default_message_ttl == var.default_message_ttl
    error_message  = "azurerm_servicebus_queue default_message_ttl must be set"
  }
  
}

run "apply" {

    command = apply

    variables {
      name                            = "azasbstandardqueue"
      namespace_id                    = run.setup.namespace_id
      default_message_ttl             = "PT1M"
    }

    assert {
      condition       = output.id != "" && output.id != null
      error_message  = "output id is empty"
    }
}