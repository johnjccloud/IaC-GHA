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

}
provider "azurerm" {
  features {}
}