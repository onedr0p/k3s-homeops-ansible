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

resource "azurerm_virtual_network_peering" "k3s-bootstrap-vnet" {
  name = "k3s2parent"
  resource_group_name = var.rg_name
  virtual_network_name = azurerm_virtual_network.k3s-bootstrap-vnet.name
  remote_virtual_network_id = var.vnet_parent_id
  use_remote_gateways = false
  allow_virtual_network_access = true
  allow_forwarded_traffic = true
}

resource "azurerm_virtual_network_peering" "parent-vnet" {
  name = "parent2k3s"
  resource_group_name = var.vnet_parent_rg_name
  virtual_network_name = var.vnet_parent_name
  remote_virtual_network_id = azurerm_virtual_network.k3s-bootstrap-vnet.id
  allow_gateway_transit = true
  allow_virtual_network_access = true
  allow_forwarded_traffic = true
}
