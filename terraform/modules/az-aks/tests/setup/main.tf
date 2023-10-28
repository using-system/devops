data "azurerm_resource_group" "test" {
  name = "tf-test-rg"
}

data "azurerm_client_config" "current" {}


resource "azurerm_log_analytics_workspace" "test" {
  name                = "system-az-aks-ana"
  location            = data.azurerm_resource_group.test.location
  resource_group_name = data.azurerm_resource_group.test.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_virtual_network" "test" {
  name                = "az-aks-vnet"
  address_space       = ["192.168.0.0/16"]
  location            = data.azurerm_resource_group.test.location
  resource_group_name = data.azurerm_resource_group.test.name
}

resource "azurerm_subnet" "test" {
  name                 = "ClusterSubnet"
  resource_group_name  = data.azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.test.name
  address_prefixes     = ["192.168.0.0/24"]
}

resource "azurerm_route_table" "test" {
  name                          = "system-aks-rt"
  location                      = data.azurerm_resource_group.test.location
  resource_group_name           = data.azurerm_resource_group.test.name
  disable_bgp_route_propagation = false
  tags = {
    environment = "Test"
  }
}

resource "azurerm_subnet_route_table_association" "test" {

  subnet_id      = azurerm_subnet.test.id
  route_table_id = azurerm_route_table.test.id
}

resource "azurerm_network_security_group" "test" {

  name                = "system-aks-nsg"
  location            = data.azurerm_resource_group.test.location
  resource_group_name = data.azurerm_resource_group.test.name
}

resource "azurerm_subnet_network_security_group_association" "network" {

  subnet_id                 = azurerm_subnet.test.id
  network_security_group_id = azurerm_network_security_group.test.id
}


resource "azurerm_user_assigned_identity" "test" {
  location            = data.azurerm_resource_group.test.location
  name                = "az-aks-identity"
  resource_group_name = data.azurerm_resource_group.test.name
}

resource "azurerm_role_assignment" "test" {
  scope                = data.azurerm_resource_group.test.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.test.principal_id
}

output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}

output "resource_group_name" {
  value = data.azurerm_resource_group.test.name
}

output "resource_group_location" {
  value = data.azurerm_resource_group.test.location
}

output "log_analytics_id" {
  value = azurerm_log_analytics_workspace.test.id
}

output "subnet_id" {
  value = azurerm_subnet.test.id
}

output "assigned_identity_id" {
  value = azurerm_user_assigned_identity.test.id
}
