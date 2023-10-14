
data "azurerm_resource_group" "test" {
  name = "tf-test-rg"
}

resource "azurerm_log_analytics_workspace" "cae" {
  name                = "system-az-acae-ana"
  location            = data.azurerm_resource_group.test.location
  resource_group_name = data.azurerm_resource_group.test.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_virtual_network" "cae" {
  name                = "system-az-acae-vnet"
  location            = data.azurerm_resource_group.test.location
  resource_group_name = data.azurerm_resource_group.test.name
  address_space       = ["10.0.0.0/16"]

  subnet {
    name           = "AcaSubnet"
    address_prefix = "10.0.0.0/23"
  }


  tags = {
    environment = "Test"
  }
}

data "azurerm_subnet" "cae" {

  depends_on = [azurerm_virtual_network.cae]

  name                 = "AcaSubnet"
  virtual_network_name = azurerm_virtual_network.cae.name
  resource_group_name  = data.azurerm_resource_group.test.name
}

output "resource_group_name" {
  value = data.azurerm_resource_group.test.name
}

output "resource_group_location" {
  value = data.azurerm_resource_group.test.location
}

output "log_analytics_id" {
  value = azurerm_log_analytics_workspace.cae.id
}

output "subnet_id" {
  value = data.azurerm_subnet.cae.id
}
