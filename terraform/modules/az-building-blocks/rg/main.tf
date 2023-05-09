resource "azurerm_resource_group" "rg" {
  name                      =  var.name
  location                  =  var.location
  tags                      =  var.tags
}

resource "azurerm_management_lock" "rg_lock" {

  depends_on = [ azurerm_resource_group.rg ]

  name       = "${azurerm_resource_group.rg.name}-lock"
  scope      = azurerm_resource_group.rg.id
  lock_level = "CanNotDelete"
  
}