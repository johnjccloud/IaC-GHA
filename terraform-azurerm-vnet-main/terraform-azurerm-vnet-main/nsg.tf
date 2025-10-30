resource "azurerm_network_security_group" "vm-grp" {
  name                = "vm-nsg"
  location            = var.vnet_location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-HTTPS"
    priority                   = 201
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 202
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-SSH-Internal"
    priority                   = 203
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-HTTPS-Internal"
    priority                   = 204
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }

    security_rule {
    name                       = "Allow-HTTPS-Internet"
    priority                   = 205
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

}
resource "azurerm_subnet_network_security_group_association" "sg-vmsubnet" {
  subnet_id = azurerm_subnet.vmsubnet.id
  network_security_group_id = azurerm_network_security_group.vm-grp.id
}

resource "azurerm_network_security_group" "app-grp" {
  name                = "app-nsg"
  location            = var.vnet_location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-HTTP"
    priority                   = 201
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  
 security_rule {
    name                       = "Allow-RDP"
    priority                   = 202
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

   security_rule {
    name                       = "Allow-Any"
    priority                   = 203
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-SQL"
    priority                   = 204
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }

}
resource "azurerm_subnet_network_security_group_association" "sg-appsubnet" {
  subnet_id = azurerm_subnet.appsubnet.id
  network_security_group_id = azurerm_network_security_group.app-grp.id
}

resource "azurerm_network_security_group" "db-grp" {
  name                = "db-nsg"
  location            = var.vnet_location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-SQL"
    priority                   = 201
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }
}
resource "azurerm_subnet_network_security_group_association" "sg-dbsubnet" {
  subnet_id = azurerm_subnet.dbsubnet.id
  network_security_group_id = azurerm_network_security_group.db-grp.id
}

resource "azurerm_network_security_group" "test-grp" {
  name                = "test-nsg"
  location            = var.vnet_location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-SQL"
    priority                   = 201
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "test-grp2" {
  name                = "test-nsg2"
  location            = var.vnet_location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-RDP"
    priority                   = 201
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-CIFS"
    priority                   = 202
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "445"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

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
  destination_port_range      = "3398"
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