#------------------------------------------------------------------------------
# Create terraform account to keep tfstate
#------------------------------------------------------------------------------

terraform {

  required_version = ">= 0.13"
  required_providers {
      azurerm = {
        source  = "hashicorp/azurerm"
        version = "=3.53.0"
      }

      azuread = {
        source  = "hashicorp/azuread"
        version = "=2.37.2"
      }

      local   = {
        source  = "hashicorp/local"
        version = "=2.4.0"
      }
  }
}

#------------------------------------------------------------------------------
# Configure the Microsoft Azure Provider
#------------------------------------------------------------------------------

provider "azurerm" {
  subscription_id = "00000000-0000-0000-0000-000000000000"
  tenant_id       = "00000000-0000-0000-0000-000000000000"
  features {}
}