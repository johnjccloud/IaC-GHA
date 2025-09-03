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

  virtual_network_id = azurerm_virtual_network.vnet.id
  dns_servers        = var.dns_servers
}

resource "azurerm_subnet" "appsubnet" {
  address_prefixes                              = var.vnet1_subnet_prefix
  name                                          = var.vnet1_subnet_name
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = azurerm_virtual_network.vnet.name
  private_endpoint_network_policies             = (lookup(var.subnet_enforce_private_link_endpoint_network_policies, var.subnet_names[count.index], false) != null) ? (lookup(var.subnet_enforce_private_link_endpoint_network_policies, var.subnet_names[count.index], false) ? ("Disabled") : ("Enabled")) : ("Enabled")
  private_link_service_network_policies_enabled = (lookup(var.subnet_enforce_private_link_service_network_policies, var.subnet_names[count.index], false) != null) ? (!lookup(var.subnet_enforce_private_link_service_network_policies, var.subnet_names[count.index], false)) : (true)
  service_endpoints                             = lookup(var.subnet_service_endpoints, var.subnet_names[count.index], null)

  dynamic "delegation" {
    for_each = lookup(var.subnet_delegation, var.subnet_names[count.index], {})

    content {
      name = delegation.key

      service_delegation {
        name    = lookup(delegation.value, "service_name")
        actions = lookup(delegation.value, "service_actions", [])
      }
    }
  }
}

