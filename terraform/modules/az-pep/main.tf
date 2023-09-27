resource "azurerm_private_endpoint" "pep" {

  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  subnet_id = var.subnet_id

  dynamic "private_dns_zone_group" {
    for_each = length(var.private_dns_zone_ids) > 0 ? [1] : []
    content {
      name                 = "${var.name}-dzg"
      private_dns_zone_ids = var.private_dns_zone_ids
    }
  }

  private_service_connection {
    name                           = "${var.name}-cnx"
    private_connection_resource_id = var.private_connection_resource_id
    subresource_names              = var.subresource_names
    is_manual_connection           = false
  }

  tags = var.tags
}
