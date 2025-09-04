terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~> 3.0"
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
  features {}
}