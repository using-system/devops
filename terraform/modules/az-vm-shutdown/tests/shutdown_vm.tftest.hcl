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
    location                    = run.setup.resource_group_location
    vm_id                       = run.setup.vm_id
    daily_recurrence_time       = "0200"
    timezone                    = "Romance Standard Time"
  }


  assert {
    condition      = azurerm_dev_test_global_vm_shutdown_schedule.vm.virtual_machine_id == var.vm_id
    error_message  = "azurerm_dev_test_global_vm_shutdown_schedule virtual_machine_id must be set"
  }

  assert {
    condition      = azurerm_dev_test_global_vm_shutdown_schedule.vm.location == var.location
    error_message  = "azurerm_dev_test_global_vm_shutdown_schedule location must be set"
  }

  assert {
    condition      = azurerm_dev_test_global_vm_shutdown_schedule.vm.enabled == true
    error_message  = "azurerm_dev_test_global_vm_shutdown_schedule enabled must be set to true"
  }

  assert {
    condition      = azurerm_dev_test_global_vm_shutdown_schedule.vm.daily_recurrence_time == var.daily_recurrence_time
    error_message  = "azurerm_dev_test_global_vm_shutdown_schedule daily_recurrence_time must be set"
  }

  assert {
    condition      = azurerm_dev_test_global_vm_shutdown_schedule.vm.timezone == var.timezone
    error_message  = "azurerm_dev_test_global_vm_shutdown_schedule timezone must be set"
  }

  assert {
    condition      = azurerm_dev_test_global_vm_shutdown_schedule.vm.notification_settings[0].enabled == false
    error_message  = "azurerm_dev_test_global_vm_shutdown_schedule notification_settings.enabled must be set to false"
  }

}


run "apply" {

    command = apply

    variables {
        location                    = run.setup.resource_group_location
        vm_id                       = run.setup.vm_id
        daily_recurrence_time       = "0200"
        timezone                    = "Romance Standard Time"
    }

    assert {
        condition       = output.id != "" && output.id != null
        error_message  = "output id is empty"
    }

}