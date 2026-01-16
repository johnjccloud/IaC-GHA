
# Create Test Network Security Rules

resource "azurerm_network_security_group" "test-grp2" {
  name                = "test-nsg2"
  location            = var.vnet_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_rule" "in" {
  name                        = "Allow-Internet"
  priority                    = 204
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.test-grp2.name
}
resource "azurerm_network_security_rule" "in2" {
  name                        = "Allow-Internal"
  priority                    = 205
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.test-grp2.name
}
