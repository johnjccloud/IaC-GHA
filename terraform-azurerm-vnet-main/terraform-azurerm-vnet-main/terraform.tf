terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~> 2.0"
        }
        modtm = {
          source  = "Azure/modtm"
          version = "0.3.2"
        }
      }    
    backend "azurerm" {
        use_azuread_auth = true
        key = "app.terraform.tfstate"
    }
}
provider "azurerm" {
  subscription_id = var.subscription_id
  client_id = var.client_id
  tenant_id = var.tenant_id
  version = "=2.0.0" 
  features {}
}