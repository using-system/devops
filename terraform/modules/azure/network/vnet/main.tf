locals {
  subnets_with_nsg = flatten([
    for subnet in var.configuration.subnets : [
      for nsg in var.configuration.network_security_groups :
      {
        name                    = subnet.name
        network_security_group  = subnet.network_security_group
      } if subnet.network_security_group != null && subnet.network_security_group != ""
    ]
  ])
}

resource "azurerm_resource_group" "network" {
  count = var.create_resource_group ? 1 : 0

  name                      =  var.resource_group_name
  location                  =  var.location
  tags                      =  var.tags
}

resource "azurerm_virtual_network" "network" {

  depends_on = [ azurerm_resource_group.network ] 

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

resource "azurerm_network_security_group" "network" {

  depends_on = [ azurerm_resource_group.network ] 

  for_each = { for nsg in var.configuration.network_security_groups : nsg.name => nsg }

    name                                          = "${each.key}-nsg"
    location                                      = var.location
    resource_group_name                           = var.resource_group_name


    dynamic "security_rule" {
      for_each = each.value.rules
      content {
        name                      = security_rule.value.name
        priority                  = security_rule.value.priority
        direction                 = security_rule.value.direction
        access                    = security_rule.value.access
        protocol                  = security_rule.value.protocol
        source_address_prefix     = security_rule.value.source_address_prefix
        source_port_range         = security_rule.value.source_port_range
        destination_address_prefix= security_rule.value.destination_address_prefix
        destination_port_range    = security_rule.value.destination_port_range
      }
    }
}

resource "azurerm_subnet_network_security_group_association" "network" {

   depends_on = [ azurerm_subnet.network, azurerm_network_security_group.network ]

   for_each = { for subnet in local.subnets_with_nsg : subnet.name => subnet } 
   
    subnet_id                 = azurerm_subnet.network[each.value.name].id 
    network_security_group_id = azurerm_network_security_group.network[each.value.network_security_group].id
}


/*

Route table to be supported later....
resource "azurerm_route_table" "network" {

  depends_on = [ azurerm_resource_group.network ] 

  for_each = { for subnet in var.configuration.subnets : subnet.name => subnet }

  name                = "${each.key}-routetable"
  location            = var.location
  resource_group_name = var.resource_group_name
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

*/