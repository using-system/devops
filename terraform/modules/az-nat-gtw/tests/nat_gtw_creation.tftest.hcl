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
    name                        = "system-az-nat-gtw"
    resource_group_name         = run.setup.resource_group_name
    location                    = run.setup.resource_group_location
    availability_zones          = ["2"]
    public_ips                  = [
        {
            ip_version          = "IPv4"
            sku                 = "Standard"
            availability_zones  = ["2"]
        } ]
    subnet_ids                  = run.setup.subnet_ids

    tags                        = { Environment = "Test" }
  }

  assert {
    condition       = length(azurerm_public_ip.nat_gtw) == 1
    error_message  = "nat gtw public ips must contains one element"
  }

  assert {
    condition      = azurerm_public_ip.nat_gtw[0].name == "pip-${var.name}-0"
    error_message  = "nat gtw public ip name must be set"
  }

  assert {
    condition      = azurerm_public_ip.nat_gtw[0].location == var.location
    error_message  = "nat gtw public ip location must be set"
  }

  assert {
    condition      = azurerm_public_ip.nat_gtw[0].resource_group_name == var.resource_group_name
    error_message  = "nat gtw public ip resource_group_name must be set"
  }

  assert {
    condition      = azurerm_public_ip.nat_gtw[0].ip_version == var.public_ips[0].ip_version
    error_message  = "nat gtw public ip ip_version must be set"
  }

  assert {
    condition      = azurerm_public_ip.nat_gtw[0].allocation_method == "Static"
    error_message  = "nat gtw public ip allocation_method must be set to Static by default"
  }

  assert {
    condition      = azurerm_public_ip.nat_gtw[0].sku == "Standard"
    error_message  = "nat gtw public ip sku must be set to Standard by default"
  }

  assert {
    condition      = azurerm_public_ip.nat_gtw[0].zones == toset(var.availability_zones)
    error_message  = "nat gtw public ip zones must be set"
  }

  assert {
    condition       = length(azurerm_public_ip.nat_gtw[0].tags) == 1
    error_message  = "nat gtw public ip tags must contains one element"
  }

  assert {
    condition      = azurerm_nat_gateway.nat_gtw.name == var.name
    error_message  = "nat gtw name must be set"
  }

  assert {
    condition      = azurerm_nat_gateway.nat_gtw.resource_group_name == var.resource_group_name
    error_message  = "nat gtw resource_group_name must be set"
  }

  assert {
    condition      = azurerm_nat_gateway.nat_gtw.location == var.location
    error_message  = "nat gtw location must be set"
  }

  assert {
    condition      = azurerm_nat_gateway.nat_gtw.sku_name == "Standard"
    error_message  = "nat gtw sku_name must be set to Standard by default"
  }

  assert {
    condition      = azurerm_nat_gateway.nat_gtw.idle_timeout_in_minutes == 4
    error_message  = "nat gtw idle_timeout_in_minutes must be set to 4 by default"
  }

  assert {
    condition      = azurerm_nat_gateway.nat_gtw.zones == toset(var.availability_zones) 
    error_message  = "nat gtw zones must be set"
  }

  assert {
    condition       = length(azurerm_nat_gateway.nat_gtw.tags) == 1
    error_message  = "nat gtw tags must contains one element"
  }

  assert {
    condition       = length(azurerm_nat_gateway_public_ip_association.nat_gtw) == 1
    error_message  = "azurerm_nat_gateway_public_ip_association must contains one element"
  }

  assert {
    condition       = length(azurerm_subnet_nat_gateway_association.nat_gtw) == 2
    error_message  = "azurerm_subnet_nat_gateway_association must contains two elements"
  }

}

run "apply" {

    command = apply

    variables {
      name                        = "system-az-nat-gtw"
      resource_group_name         = run.setup.resource_group_name
      location                    = run.setup.resource_group_location
      availability_zones          = ["2"]
      public_ips                  = [
          {
              ip_version          = "IPv4"
              sku                 = "Standard"
              availability_zones  = ["2"]
          } ]
      subnet_ids                  = run.setup.subnet_ids

      tags                        = { Environment = "Test" }
    }

    assert {
        condition       = output.id != "" && output.id != null
        error_message  = "output id is empty"
    }

    assert {
        condition       = output.resource_guid != "" && output.resource_guid != null
        error_message  = "output resource_guid is empty"
    }
}
