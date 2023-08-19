resource "azurerm_private_dns_zone_virtual_network_link" "dns" {
  name                = var.name
  resource_group_name = var.resource_group_name

  private_dns_zone_name = var.private_dns_zone_name
  virtual_network_id    = var.vnet_id
  registration_enabled  = var.registration_enabled

  tags = var.tags
}
