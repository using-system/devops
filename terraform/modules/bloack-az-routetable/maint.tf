resource "azurerm_route_table" "network" {

  for_each = { for table in var.route_tables : table.name => table }

    name                              = "${each.key}-rt"
    location                          = var.location
    resource_group_name               = var.resource_group_name
    disable_bgp_route_propagation     =  each.value.disable_bgp_route_propagation

    dynamic "route" {
        for_each = each.value.routes
        content {
            name                                        = route.value.name
            address_prefix                              = route.value.address_prefix
            next_hop_type                               = route.value.next_hop_type
            next_hop_in_ip_address                      = route.value.next_hop_in_ip_address
        }
    }

    tags                              = var.tags
  
}