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
  destination_port_range      = "*"
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
  destination_port_range      = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.test-grp2.name
}
resource "azurerm_network_security_rule" "in3" {
  name                        = "Allow-RDP-Internet"
  priority                    = 206
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

resource "azurerm_network_security_rule" "in4" {
  name                        = "Allow-SSH-Internal"
  priority                    = 207
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.test-grp2.name
}

resource "azurerm_network_security_rule" "in5" {
  name                        = "Allow-HTTPS-AnyIP"
  priority                    = 208
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "0.0.0.0/0"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.test-grp2.name
}

resource "azurerm_network_security_rule" "in6" {
  name                        = "Allow-HTTPS-VirtualNetwork"
  priority                    = 209
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.test-grp2.name
}

resource "azurerm_network_security_rule" "in7" {
  name                        = "Allow-FTP-VirtualNetwork"
  priority                    = 210
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "23"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.test-grp2.name
}

resource "azurerm_network_security_rule" "in8" {
  name                        = "Allow-FTP-10"
  priority                    = 211
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "23"
  source_address_prefix       = "10.0.0.0/8"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.test-grp2.name
}

resource "azurerm_network_security_rule" "in9" {
  name                        = "Allow-RDP-10"
  priority                    = 212
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3398"
  source_address_prefix       = "10.0.0.0/8"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.test-grp2.name
}