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
    location                = run.setup.resource_group_location
    resource_group_name     = run.setup.resource_group_name
    name                    = "az-vm-linux-vm"
    size                    = "Standard_B2s"
    image                   = {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }
    admin_username          = "jdsud9$*sdkdiu2dIN"
    public_key_openssh      = run.setup.public_key_openssh
    subnet_id               = run.setup.subnet_id
    disk_encryption_set_id  = null
    identity_ids            = [ run.setup.assigned_identity_id ]

    tags                    = { Environment = "Test" }
  }

  assert {
    condition      = azurerm_network_interface.vm.name == "${var.name}-nic"
    error_message  = "azurerm_network_interface name must be set"
  }

  assert {
    condition      = azurerm_network_interface.vm.location == var.location
    error_message  = "azurerm_network_interface location must be set"
  }

  assert {
    condition      = azurerm_network_interface.vm.resource_group_name == var.resource_group_name
    error_message  = "azurerm_network_interface resource_group_name must be set"
  }

  assert {
    condition      = azurerm_network_interface.vm.ip_configuration[0].subnet_id == var.subnet_id
    error_message  = "azurerm_network_interface subnet_id must be set"
  }

  assert {
    condition       = length(azurerm_network_interface.vm.tags) == 1
    error_message  = "azurerm_network_interface tags must contains one element"
  }

  assert {
    condition      = azurerm_linux_virtual_machine.vm.name == "${var.name}-vm"
    error_message  = "azurerm_linux_virtual_machine name must be set"
  }

  assert {
    condition      = azurerm_linux_virtual_machine.vm.resource_group_name == var.resource_group_name
    error_message  = "azurerm_linux_virtual_machine resource_group_name must be set"
  }

  assert {
    condition      = azurerm_linux_virtual_machine.vm.location == var.location
    error_message  = "azurerm_linux_virtual_machine location must be set"
  }

  assert {
    condition      = azurerm_linux_virtual_machine.vm.size == var.size
    error_message  = "azurerm_linux_virtual_machine size must be set"
  }

  assert {
    condition      = azurerm_linux_virtual_machine.vm.admin_username == var.admin_username
    error_message  = "azurerm_linux_virtual_machine admin_username must be set"
  }

  assert {
    condition      = azurerm_linux_virtual_machine.vm.os_disk[0].storage_account_type == var.storage_account_type
    error_message  = "azurerm_linux_virtual_machine os_disk storage_account_type must be set"
  }

  assert {
    condition       = length(azurerm_linux_virtual_machine.vm.identity) == 1
    error_message  = "azurerm_linux_virtual_machine identity must contains one element"
  }

  assert {
    condition      = azurerm_linux_virtual_machine.vm.allow_extension_operations == false
    error_message  = "azurerm_linux_virtual_machine allow_extension_operations must be set to false by default"
  }

  assert {
    condition       = length(azurerm_linux_virtual_machine.vm.tags) == 1
    error_message  = "azurerm_linux_virtual_machine tags must contains one element"
  }

}