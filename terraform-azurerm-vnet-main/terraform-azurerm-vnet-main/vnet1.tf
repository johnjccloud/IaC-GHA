resource "azurerm_virtual_network" "vnet1" {
  address_space       = var.vnet1_address_space
  location            = var.vnet_location
  name                = var.vnet1_name
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

resource "azurerm_virtual_network_dns_servers" "vnet1dns" {
  count = var.dns_servers != null ? 1 : 0

  virtual_network_id = azurerm_virtual_network.vnet1.id
  dns_servers        = var.dns_servers
}

resource "azurerm_subnet" "appsubnet" {
  address_prefixes                              = var.vnet1_subnet_prefix
  name                                          = var.vnet1_subnet_name
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = azurerm_virtual_network.vnet1.name
 
}

