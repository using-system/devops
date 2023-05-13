resource "azurerm_network_security_group" "network" {

  for_each = { for nsg in var.network_security_groups : nsg.name => nsg }

    name                                          = "${each.key}-nsg"
    location                                      = var.location
    resource_group_name                           = var.resource_group_name


    dynamic "security_rule" {
      for_each = each.value.rules
      content {
        name                                      = security_rule.value.name
        priority                                  = security_rule.value.priority
        direction                                 = security_rule.value.direction
        access                                    = security_rule.value.access
        protocol                                  = security_rule.value.protocol
        source_address_prefix                     = security_rule.value.source_address_prefix
        source_port_range                         = security_rule.value.source_port_range
        destination_address_prefix                = security_rule.value.destination_address_prefix
        destination_port_range                    = security_rule.value.destination_port_range
      }
    }
    
    tags                                            =  var.tags
}
