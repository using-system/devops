data "azurerm_resource_group" "test" {
  name = "tf-test-rg"
}

resource "tls_private_key" "test" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_virtual_network" "test" {
  name                = "az-vm-linux-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.test.location
  resource_group_name = data.azurerm_resource_group.test.name
}

resource "azurerm_subnet" "test" {
  name                 = "vm-subnet"
  resource_group_name  = data.azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.test.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_user_assigned_identity" "test" {
  location            = data.azurerm_resource_group.test.location
  name                = "az-vm-linux-identity"
  resource_group_name = data.azurerm_resource_group.test.name
}

output "resource_group_name" {
  value = data.azurerm_resource_group.test.name
}

output "resource_group_location" {
  value = data.azurerm_resource_group.test.location
}

output "public_key_openssh" {
  value = tls_private_key.test.public_key_openssh
}

output "subnet_id" {
  value = azurerm_subnet.test.id
}

output "assigned_identity_id" {
  value = azurerm_user_assigned_identity.test.id
}
