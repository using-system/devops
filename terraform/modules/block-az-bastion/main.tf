resource "azurerm_public_ip" "bastion" {

  count = (var.enabled == true ? 1 : 0)

  name                = "${var.name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion" {

  count = (var.enabled == true ? 1 : 0)

  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.bastion[0].id
  }

  sku                = var.sku
  copy_paste_enabled = var.copy_paste_enabled
  file_copy_enabled  = var.file_copy_enabled
  scale_units        = var.scale_units
  ip_connect_enabled = var.ip_connect_enabled

  tags = var.tags
}
