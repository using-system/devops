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

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "${var.name}-vm"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.size
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.vm.id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.public_key_openssh
  }

  os_disk {
    caching                = "ReadOnly"
    storage_account_type   = var.storage_account_type
    disk_encryption_set_id = var.disk_encryption_set_id

    diff_disk_settings = {
      option    = "Local"
      placement = "CacheDisk"
    }
  }

  source_image_reference {
    publisher = var.image.publisher
    offer     = var.image.offer
    sku       = var.image.sku
    version   = var.image.version
  }

  identity {
    type         = "UserAssigned"
    identity_ids = var.identity_ids
  }

  allow_extension_operations = var.allow_extension_operations

  tags = var.tags
}
