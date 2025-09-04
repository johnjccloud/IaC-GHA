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
  subscription_id = "58c4307d-1129-4116-a1e7-782415146818"
  client_id = "90367a60-e3ea-4618-9953-e85ce291ff39"
  tenant_id = "fa97859f-1a91-4ae1-ba3e-05a73b452efd"
  features {}
}