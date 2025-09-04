resource "azurerm_virtual_network" "vnet" {
  address_space       = var.address_space
  location            = var.vnet_location
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  bgp_community       = var.bgp_community
  dynamic "ddos_protection_plan" {
    for_each = var.ddos_protection_plan != null ? [var.ddos_protection_plan] : []

    content {
      enable = ddos_protection_plan.value.enable
      id     = ddos_protection_plan.value.id
    }
  }

  lifecycle {
    ignore_changes = [dns_servers]
  } 
}

resource "azurerm_virtual_network_dns_servers" "dns" {
  count = var.dns_servers != null ? 1 : 0

  virtual_network_id = azurerm_virtual_network.vnet.id
  dns_servers        = var.dns_servers
}

resource "azurerm_subnet" "vmsubnet" {
  address_prefixes                              = var.vmsubnet_prefix
  name                                          = var.vmsubnet_name
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = azurerm_virtual_network.vnet.name
}

resource "azurerm_subnet" "appsubnet" {
  address_prefixes                              = var.appsubnet_prefix
  name                                          = var.appsubnet_name
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = azurerm_virtual_network.vnet.name
}

resource "azurerm_subnet" "dbsubnet" {
  address_prefixes                              = var.dbsubnet_prefix
  name                                          = var.dbsubnet_name
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = azurerm_virtual_network.vnet.name
}
