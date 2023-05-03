locals {
  nsgs    = distinct(flatten([
    for subnet in var.configuration.subnets : [
      subnet.network_security_group
    ]
  ]))
  subnets_with_nsg = [
    for subnet in var.configuration.subnets :
    subnet
    if try(length(subnet.network_security_group), 0) > 0
  ]
  route_tables    = distinct(flatten([
    for subnet in var.configuration.subnets : [
      subnet.route_table
    ]
  ]))
  subnets_with_rt  = [
    for subnet in var.configuration.subnets :
    subnet
    if try(length(subnet.route_table), 0) > 0
  ]
  
}

resource "azurerm_virtual_network" "network" {
  
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name

  address_space                 = var.configuration.address_spaces

  tags                          =  var.tags
}

resource "azurerm_subnet" "network" {

  depends_on = [ azurerm_virtual_network.network ] 

  for_each = { for subnet in var.configuration.subnets : subnet.name => subnet }
    
    name                                              = each.key
    resource_group_name                               = var.resource_group_name
    virtual_network_name                              = azurerm_virtual_network.network.name
    address_prefixes                                  = each.value.address_prefixes
    service_endpoints                                 = each.value.service_endpoints
    private_link_service_network_policies_enabled     = each.value.private_link_service_network_policies_enabled
    private_endpoint_network_policies_enabled         = each.value.private_endpoint_network_policies_enabled
}

data "azurerm_network_security_group" "network" {

  for_each = { for nsg in local.nsgs : nsg => nsg }

    name                                          = "${each.key}-nsg"
    resource_group_name                           = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "network" {

   depends_on = [ azurerm_subnet.network ]

   for_each = { for subnet in local.subnets_with_nsg : subnet.name => subnet } 
   
    subnet_id                 = azurerm_subnet.network[each.value.name].id 
    network_security_group_id = data.azurerm_network_security_group.network[each.value.network_security_group].id
}

data "azurerm_route_table" "network" {

  for_each = { for table in local.route_tables : table => table }

    name                              = "${each.key}-rt"
    resource_group_name               = var.resource_group_name
}

resource "azurerm_subnet_route_table_association" "network" {

  depends_on = [ azurerm_subnet.network ]

  for_each = { for subnet in local.subnets_with_rt : subnet.name => subnet }    

    subnet_id                                      = azurerm_subnet.network[each.value.name].id
    route_table_id                                 = data.azurerm_route_table.network[each.value.route_table].id
}