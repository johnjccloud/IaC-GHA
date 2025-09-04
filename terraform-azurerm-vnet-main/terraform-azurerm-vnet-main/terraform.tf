
terraform {
  required_version = ">= 1.3.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"
    }
    modtm = {
      source  = "Azure/modtm"
      version = "0.3.2"
    }
  }
  
  backend "azurerm" {
        key = "app.terraform.tfstate"
    }
}

provider "azurerm" {
  features {}
}