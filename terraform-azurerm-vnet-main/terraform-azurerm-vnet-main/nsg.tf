resource "azurerm_network_security_group" "sec-grp" {
  name                = var.nsg_name
  location            = var.nsg_location
  resource_group_name = var.resource_group_name

# For HTTP traffic
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
resource "azurerm_subnet_network_security_group_association" "sg-asso" {
  subnet_id = local.azurerm_subnets[*].id
  network_security_group_id = azurerm_network_security_group.sec-grp.id
  depends_on = [
    azurerm_network_security_group.sec-grp
  ]
}