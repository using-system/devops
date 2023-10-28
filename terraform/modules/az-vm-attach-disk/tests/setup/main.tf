data "azurerm_resource_group" "test" {
  name = "tf-test-rg"
}

resource "azurerm_virtual_network" "test" {
  name                = "az-vm-attach-disk-vnet"
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

resource "azurerm_network_interface" "test" {
  name                = "az-vm-attach-disk-nic"
  location            = data.azurerm_resource_group.test.location
  resource_group_name = data.azurerm_resource_group.test.name

  ip_configuration {
    name                          = "config"
    subnet_id                     = azurerm_subnet.test.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  name                  = "az-vm-attach-disk-vm"
  location              = data.azurerm_resource_group.test.location
  resource_group_name   = data.azurerm_resource_group.test.name
  network_interface_ids = [azurerm_network_interface.test.id]
  size                  = "Standard_B2s"

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  os_disk {
    name                 = "az-vm-attach-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_username                  = "testadmin"
  admin_password                  = "Password1234!"
  disable_password_authentication = false
}

output "resource_group_name" {
  value = data.azurerm_resource_group.test.name
}

output "resource_group_location" {
  value = data.azurerm_resource_group.test.location
}

output "vm_id" {
  value = azurerm_linux_virtual_machine.test.id
}
