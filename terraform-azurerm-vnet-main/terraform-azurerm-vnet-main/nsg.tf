resource "azurerm_network_security_group" "vm-grp" {
  name                = "vm-nsg"
  location            = var.vnet_location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-HTTPS"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
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
    name                       = "Allow-HTTPS"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
resource "azurerm_subnet_network_security_group_association" "sg-appsubnet" {
  subnet_id = azurerm_subnet.appsubnet.id
  network_security_group_id = azurerm_network_security_group.app-grp.id
}