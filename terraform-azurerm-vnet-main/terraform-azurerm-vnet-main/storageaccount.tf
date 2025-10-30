resource "azurerm_storage_account" "example" {
  name                     = var.storageaccount_name
  resource_group_name      = var.resource_group_name
  location                 = var.vnet_location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  }

resource "azurerm_storage_account" "example2" {
  name                     = var.storageaccount2_name
  resource_group_name      = var.resource_group_name
  location                 = var.vnet_location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  }

resource "azurerm_storage_account" "example3" {
  name                     = var.storageaccount3_name
  resource_group_name      = var.resource_group_name
  location                 = var.vnet_location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  }

  resource "azurerm_storage_account" "example4" {
  name                     = var.storageaccount4_name
  resource_group_name      = var.resource_group_name
  location                 = var.vnet_location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  }