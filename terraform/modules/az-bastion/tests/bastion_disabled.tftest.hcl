provider "azurerm" {
  features {
  }
}

run "apply" {

    command = apply

    variables {
      location                = "westeu"
      resource_group_name     = "tf-test-rg"
      name                    = "system-az-bastion-bastion"
      subnet_id               = "subnet_id"
      enabled                 = false

      tags                    = { Environment = "Test" }
    }

    assert {
        condition       = length(azurerm_public_ip.bastion) == 0
        error_message  = "public ip array must be empty"
    }

    assert {
        condition       = length(azurerm_bastion_host.bastion) == 0
        error_message  = "bastion host array must be empty"
    }

    assert {
        condition       = output.id == null
        error_message  = "output id must be null"
    }

    assert {
        condition       = output.dns_name == null
        error_message  = "output dns_name must be null"
    }

    assert {
        condition       = output.public_ip == null
        error_message  = "output public_ip must be null"
    }
}