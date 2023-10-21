resource "azurerm_subnet_nat_gateway_association" "nat_gtw" {

  count = length(var.subnet_ids)

  subnet_id      = var.subnet_ids[count.index]
  nat_gateway_id = var.nat_gateway_id
}
