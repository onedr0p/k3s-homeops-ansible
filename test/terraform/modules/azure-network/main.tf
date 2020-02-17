resource "azurerm_virtual_network" "k3s-bootstrap-vnet" {
  name = var.vnet_name
  address_space = var.vnet_address_space
  resource_group_name = var.rg_name
  location = var.location
}

resource "azurerm_subnet" "k3s-bootstrap-subnet" {
  name = var.vnet_subnet_name
  resource_group_name = var.rg_name
  virtual_network_name = azurerm_virtual_network.k3s-bootstrap-vnet.name
  address_prefix = var.vnet_subnet_prefix
}
