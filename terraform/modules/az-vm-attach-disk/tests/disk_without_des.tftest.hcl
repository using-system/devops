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
    name                        = "az-vm-attach-disk"
    location                    = run.setup.resource_group_location
    resource_group_name         = run.setup.resource_group_name
    vm_id                       = run.setup.vm_id

    tags                        = { Environment = "Test" }
  }


  assert {
    condition      = azurerm_managed_disk.vm.name == var.name
    error_message  = "azurerm_managed_disk name must be set"
  }

  assert {
    condition      = azurerm_managed_disk.vm.location == var.location
    error_message  = "azurerm_managed_disk location must be set"
  }

  assert {
    condition      = azurerm_managed_disk.vm.resource_group_name == var.resource_group_name
    error_message  = "azurerm_managed_disk resource_group_name must be set"
  }

  assert {
    condition      = azurerm_managed_disk.vm.storage_account_type == "Standard_LRS"
    error_message  = "azurerm_managed_disk storage_account_type must be set to Standard_LRS by default"
  }

  assert {
    condition      = azurerm_managed_disk.vm.create_option == "Empty"
    error_message  = "azurerm_managed_disk create_option must be set to Empty by default"
  }

  assert {
    condition      = azurerm_managed_disk.vm.disk_size_gb == 10
    error_message  = "azurerm_managed_disk disk_size_gb must be set to 10 by default"
  }

  assert {
    condition      = azurerm_managed_disk.vm.public_network_access_enabled == false
    error_message  = "azurerm_managed_disk public_network_access_enabled must be set to false by default"
  }

  assert {
    condition      = azurerm_managed_disk.vm.disk_encryption_set_id == null
    error_message  = "azurerm_managed_disk disk_encryption_set_id must be null by default"
  }

  assert {
    condition       = length(azurerm_managed_disk.vm.tags) == 1
    error_message  = "azurerm_managed_disk tags storage must contains one element"
  }

  assert {
    condition      = azurerm_virtual_machine_data_disk_attachment.vm.virtual_machine_id == var.vm_id
    error_message  = "azurerm_virtual_machine_data_disk_attachment virtual_machine_id must be set"
  }

  assert {
    condition      = azurerm_virtual_machine_data_disk_attachment.vm.lun == 0
    error_message  = "azurerm_virtual_machine_data_disk_attachment lun must be set to 0 by default"
  }

  assert {
    condition      = azurerm_virtual_machine_data_disk_attachment.vm.caching == "ReadWrite"
    error_message  = "azurerm_virtual_machine_data_disk_attachment caching must be set to ReadWrite by default"
  }
}


run "apply" {

    command = apply

    variables {
        name                        = "az-vm-attach-disk"
        location                    = run.setup.resource_group_location
        resource_group_name         = run.setup.resource_group_name
        vm_id                       = run.setup.vm_id

        tags                        = { Environment = "Test" }
    }

    assert {
        condition       = output.id != "" && output.id != null
        error_message  = "output id is empty"
    }

    assert {
        condition       = output.disk_id != "" && output.disk_id != null
        error_message  = "output disk_id is empty"
    }
}