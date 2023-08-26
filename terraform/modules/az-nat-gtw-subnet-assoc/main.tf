resource "azurerm_subnet_nat_gateway_association" "sn_cluster_nat_gw" {

  for_each = toset(var.subnet_ids)

  subnet_id      = each.key
  nat_gateway_id = vat.nat_gateway_id
}
