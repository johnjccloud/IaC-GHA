resource "azurerm_storage_account" "example" {
  name                     = var.storageaccount_name
  resource_group_name      = var.resource_group_name
  location                 = var.vnet_location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  }