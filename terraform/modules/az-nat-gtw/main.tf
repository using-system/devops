locals {
  ips_with_index = { for idx, ip in var.public_ips : idx => ip }
}

resource "azurerm_public_ip_prefix" "nat_prefix" {
  for_each = local.ips_with_index

  name                = "pipp-${var.name}-${each.key}"
  resource_group_name = var.resource_group_name
  location            = var.location
  ip_version          = each.value.ip_version
  prefix_length       = each.value.prefix_length
  sku                 = each.value.sku
  zones               = each.value.availability_zones

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

resource "azurerm_nat_gateway_public_ip_prefix_association" "nat_ips" {

  for_each = local.ips_with_index

  nat_gateway_id      = azurerm_nat_gateway.nat_gtw.id
  public_ip_prefix_id = azurerm_public_ip_prefix.nat_prefix[each.key].id

}

resource "azurerm_subnet_nat_gateway_association" "sn_cluster_nat_gw" {

  for_each = toset(var.subnet_ids)

  subnet_id      = each.key
  nat_gateway_id = azurerm_nat_gateway.nat_gtw.id
}
