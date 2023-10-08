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
    name                    = "${run.setup.vnet_name}-bastion"
    subnet_id               = run.setup.subnet_id

    tags                    = { Environment = "Test" }
  }

  assert {
    condition       = length(azurerm_public_ip.bastion) == 1
    error_message  = "public ip array must contains one element"
  }

  assert {
    condition       = length(azurerm_bastion_host.bastion) == 1
    error_message  = "bastion host array must contains one element"
  }

  assert {
    condition      = azurerm_public_ip.bastion[0].location == var.location
    error_message  = "public ip location must be set"
  }

  assert {
    condition      = azurerm_public_ip.bastion[0].resource_group_name == var.resource_group_name
    error_message  = "public ip resource group name must be set"
  }

  assert {
    condition      = azurerm_public_ip.bastion[0].sku == "Standard"
    error_message  = "public ip sku must be set to Standard"
  }

  assert {
    condition      = azurerm_public_ip.bastion[0].allocation_method == "Static"
    error_message  = "public ip allocation_method must be set to Static"
  }

  assert {
    condition      = azurerm_bastion_host.bastion[0].location == var.location
    error_message  = "bastion location must be set"
  }

  assert {
    condition      = azurerm_bastion_host.bastion[0].resource_group_name == var.resource_group_name
    error_message  = "bastion resource_group_name must be set"
  }

  assert {
    condition      = azurerm_bastion_host.bastion[0].ip_configuration[0].subnet_id == var.subnet_id
    error_message  = "bastion subnet_id must be set"
  }

  assert {
    condition      = azurerm_bastion_host.bastion[0].sku == "Basic"
    error_message  = "bastion sku must be set to Basic by default"
  }

  assert {
    condition      = azurerm_bastion_host.bastion[0].copy_paste_enabled
    error_message  = "bastion copy_paste_enabled must be set to true by default"
  }

  assert {
    condition      = !azurerm_bastion_host.bastion[0].file_copy_enabled
    error_message  = "bastion file_copy_enabled must be set to false by default"
  }

  assert {
    condition      = azurerm_bastion_host.bastion[0].scale_units == 2
    error_message  = "bastion scale_units must be set to 2 by default"
  }

  assert {
    condition      = !azurerm_bastion_host.bastion[0].ip_connect_enabled
    error_message  = "bastion ip_connect_enabled must be set to false by default"
  }

}

run "apply" {

    command = apply

    variables {
      location                = run.setup.resource_group_location
      resource_group_name     = run.setup.resource_group_name
      name                    = "${run.setup.vnet_name}-bastion"
      subnet_id               = run.setup.subnet_id

      tags                    = { Environment = "Test" }
    }

    assert {
        condition       = output.id != "" || output.id == null
        error_message  = "output id is empty"
    }

    assert {
        condition       = output.dns_name != "" || output.dns_name == null
        error_message  = "output dns_name is empty"
    }

    assert {
        condition       = azurerm_public_ip.bastion[0].id  == azurerm_bastion_host.bastion[0].ip_configuration[0].public_ip_address_id
        error_message  = "bastion public_ip_address_id must be assigned"
    }

    assert {
        condition       = output.public_ip == azurerm_public_ip.bastion[0].ip_address
        error_message  = "output public_ip_address_id must be assigned"
    }
}