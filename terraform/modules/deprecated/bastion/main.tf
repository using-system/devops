resource "azurerm_resource_group" "bastion" {
  name                      =  "${var.naming}-bastion-rg"
  location                  =  var.location
  tags                      =  var.tags
}

resource "azurerm_public_ip" "bastion" {
  name                      = "${var.naming}-bastion-ip" 
  location                  = var.location
  resource_group_name       = azurerm_resource_group.bastion.name
  allocation_method         = "Static"
  sku                       = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
  name                      = "${var.naming}-bastion" 
  location                  = var.location
  resource_group_name       = azurerm_resource_group.bastion.name

  ip_configuration {
    name                    = "configuration"
    subnet_id               = var.subnet_id
    public_ip_address_id    = azurerm_public_ip.bastion.id
  }
}