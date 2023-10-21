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
    nat_gateway_id     = run.setup.nat_gateway_id
    subnet_ids         = run.setup.subnet_ids
  }

  assert {
    condition       = length(azurerm_subnet_nat_gateway_association.nat_gtw) == 2
    error_message  = "azurerm_subnet_nat_gateway_association must contains two elements"
  }

  assert {
    condition      = azurerm_subnet_nat_gateway_association.nat_gtw[0].nat_gateway_id == var.nat_gateway_id
    error_message  = "azurerm_subnet_nat_gateway_association nat_gateway_id must be set"
  }

  assert {
    condition      = azurerm_subnet_nat_gateway_association.nat_gtw[0].subnet_id == var.subnet_ids[0]
    error_message  = "azurerm_subnet_nat_gateway_association subnet_id 1 must be set"
  }

   assert {
    condition      = azurerm_subnet_nat_gateway_association.nat_gtw[1].subnet_id == var.subnet_ids[1]
    error_message  = "azurerm_subnet_nat_gateway_association subnet_id 2 must be set"
  }

}

run "apply" {

    command = apply

    variables {
      nat_gateway_id     = run.setup.nat_gateway_id
      subnet_ids         = run.setup.subnet_ids
    }
}
