resource "azurerm_resource_group" "network" {
  name                      =  "${var.naming}-network-rg"
  location                  =  var.location
  tags                      =  var.tags
}

resource "azurerm_virtual_network" "network" {

  depends_on = [ azurerm_resource_group.network ] 

  name                          = "${var.naming}-network"
  location                      = var.location
  resource_group_name           = azurerm_resource_group.network.name

  address_space                 = var.configuration.address_spaces

  tags                          =  var.tags
}

resource "azurerm_network_security_group" "network" {

  for_each = { for subnet in var.configuration.subnets : subnet.name => subnet }

    name                                          = "${each.key}-nsg"
    location                                      = azurerm_resource_group.network.location
    resource_group_name                           = azurerm_resource_group.network.name
}

resource "azurerm_route_table" "network" {

  for_each = { for subnet in var.configuration.subnets : subnet.name => subnet }

  name                = "${each.key}-routetable"
  location            = azurerm_resource_group.network.location
  resource_group_name = azurerm_resource_group.network.name
}

resource "azurerm_subnet" "network" {

  depends_on = [ azurerm_virtual_network.network ] 

  for_each = { for subnet in var.configuration.subnets : subnet.name => subnet }
    
    name                                              = each.key
    resource_group_name                               = azurerm_resource_group.network.name
    virtual_network_name                              = azurerm_virtual_network.network.name
    address_prefixes                                  = each.value.address_prefixes
    service_endpoints                                 = each.value.service_endpoints
    enforce_private_link_service_network_policies     = each.value.enforce_private_link_service_network_policies
    enforce_private_link_endpoint_network_policies    = each.value.enforce_private_link_endpoint_network_policies
}

resource "azurerm_subnet_network_security_group_association" "network" {

   depends_on = [ azurerm_subnet.network, azurerm_network_security_group.network ]

   for_each = { for subnet in var.configuration.subnets : subnet.name => subnet } 
   
    subnet_id                 = azurerm_subnet.network[each.key].id
    network_security_group_id = azurerm_network_security_group.network[each.key].id
}

resource "azurerm_subnet_route_table_association" "network" {

  depends_on = [ azurerm_subnet.network, azurerm_route_table.network ]

  for_each = { for subnet in var.configuration.subnets : subnet.name => subnet }    

    subnet_id      = azurerm_subnet.network[each.key].id
    route_table_id = azurerm_route_table.network[each.key].id
}