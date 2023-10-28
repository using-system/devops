data "azurerm_resource_group" "test" {
  name = "tf-test-rg"
}

resource "azurerm_storage_account" "pep" {
  name                     = "systemazpepstorage"
  resource_group_name      = data.azurerm_resource_group.test.name
  location                 = data.azurerm_resource_group.test.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_virtual_network" "pep" {
  name                = "system-az-pep-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.test.location
  resource_group_name = data.azurerm_resource_group.test.name
}

resource "azurerm_subnet" "storage" {
  name                 = "storage"
  resource_group_name  = data.azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.pep.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_private_dns_zone" "blob" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = data.azurerm_resource_group.test.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "pep" {
  name                  = "system-az-pep-vnet-blogdns-link"
  resource_group_name   = data.azurerm_resource_group.test.name
  private_dns_zone_name = azurerm_private_dns_zone.blob.name
  virtual_network_id    = azurerm_virtual_network.pep.id
}

output "resource_group_name" {
  value = data.azurerm_resource_group.test.name
}

output "resource_group_location" {
  value = data.azurerm_resource_group.test.location
}

output "vnet_name" {
  value = azurerm_virtual_network.pep.name
}

output "subnet_id" {
  value = azurerm_subnet.storage.id
}

output "storage_account_id" {
  value = azurerm_storage_account.pep.id
}

output "private_dns_zone_ids" {
  value = azurerm_private_dns_zone.blob.id
}

