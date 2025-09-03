resource "azurerm_network_security_group" "vm-grp" {
  name                = "vm-nsg"
  location            = var.vnet_location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-HTTP"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
resource "azurerm_subnet_network_security_group_association" "sg-vmsubnet" {
  subnet_id = azurerm_subnet.vmsubnet.id
  network_security_group_id = azurerm_network_security_group.vm-grp.id
  depends_on = [
    azurerm_network_security_group.vm-grp
  ]
}