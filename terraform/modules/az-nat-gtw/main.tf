locals {
  ips_with_index = { for idx, ip in var.public_ips : idx => ip }
}

resource "azurerm_public_ip" "nat_gtw" {

  for_each = local.ips_with_index

  name                = "pip-${var.name}-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_version          = each.value.ip_version
  allocation_method   = "Static"
  sku                 = each.value.sku
  zones               = var.availability_zones

  tags = var.tags
}

resource "azurerm_nat_gateway" "nat_gtw" {
  name                    = var.name
  resource_group_name     = var.resource_group_name
  location                = var.location
  sku_name                = var.sku
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
  zones                   = var.availability_zones

  tags = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "nat_gtw" {

  for_each = local.ips_with_index

  nat_gateway_id       = azurerm_nat_gateway.nat_gtw.id
  public_ip_address_id = azurerm_public_ip.nat_gtw[each.key].id

}

resource "azurerm_subnet_nat_gateway_association" "nat_gtw" {

  for_each = toset(var.subnet_ids)

  subnet_id      = each.key
  nat_gateway_id = azurerm_nat_gateway.nat_gtw.id
}
