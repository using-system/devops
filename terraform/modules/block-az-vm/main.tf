resource "azurerm_network_interface" "vm" {

  name                = "${var.name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.name}-nic-ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

resource "random_password" "vm" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_windows_virtual_machine" "vm" {

  depends_on = [azurerm_network_interface.vm]

  name                = "${var.name}-vm"
  resource_group_name = var.resource_group_name
  location            = var.location
  computer_name       = var.name
  size                = var.size
  admin_username      = var.admin_username
  admin_password      = random_password.vm.result
  license_type        = var.license_type

  network_interface_ids = [
    azurerm_network_interface.vm.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}
