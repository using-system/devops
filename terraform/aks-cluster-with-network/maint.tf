#------------------------------------------------------------------------------
# Declare providers
#------------------------------------------------------------------------------

terraform {
  
  required_version = ">= 0.13"
  
  required_providers {
      azurerm = {
        source  = "hashicorp/azurerm"
        version = "3.29.1"
      }

      azuread = {
        source  = "hashicorp/azuread"
        version = "2.30.0"
      }

      local   = {
        source  = "hashicorp/local"
        version = "2.2.3"
      }
  }
}

#------------------------------------------------------------------------------
# Configure providers
#------------------------------------------------------------------------------

provider "azurerm" {
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  features {}
}


#------------------------------------------------------------------------------
# Monitor
#------------------------------------------------------------------------------

module "monitor" {
  source                  = "../modules/monitor"

  naming                  = var.naming
  location                = var.location
  
  configuration           = var.monitor_configuration 

  tags                    = var.tags
}


#------------------------------------------------------------------------------
# Networking
#------------------------------------------------------------------------------

module "networking" {
  source                  = "../modules/networking"

  naming                  = var.naming
  location                = var.location
  
  configuration           = var.network_configuration

  tags                    = var.tags
}


#------------------------------------------------------------------------------
# AKS
#------------------------------------------------------------------------------

module "aks" {
  source                  = "../modules/aks"

  depends_on = [ module.monitor, module.networking ]

  naming                  = var.naming
  location                = var.location
  subscription_id         = var.subscription_id

  configuration           = var.aks_configuration
  log_analytics_id        = module.monitor.log_analytics_id
  subnet_id               = module.networking.subnet_ids[var.network_configuration.k8s_sbunet_name]

  tags                    = var.tags
}