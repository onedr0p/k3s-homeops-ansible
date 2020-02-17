// Create Resource Group

resource "azurerm_resource_group" "k3s-bootstrap-rg" {
  name = var.rg_name
  location = var.location
}

// Create Network

module azure-network {
  source = "./modules/azure-network"
  location = "${var.location}"
  vnet_address_space = "${var.vnet_address_space}"
  vnet_name = "${var.vnet_name}"
  vnet_subnet_name = "${var.vnet_subnet_name}"
  vnet_subnet_prefix = "${var.vnet_subnet_prefix}"
  rg_name = azurerm_resource_group.k3s-bootstrap-rg.name
  vnet_parent_rg_name = "${var.vnet_parent_rg_name}"
  vnet_parent_name = "${var.vnet_parent_name}"
  vnet_parent_id = "${var.vnet_parent_id}"
}


// Create VMs

module azure-vms {
  source = "./modules/azure-vms"
  name_prefix = "${var.name_prefix}"
  vm_count = "${var.vm_count}"
  location = "${var.location}"
  rg_name = azurerm_resource_group.k3s-bootstrap-rg.name
  vm_size = "${var.vm_size}"
  os_publisher = "${var.os_publisher}"
  os_offer = "${var.os_offer}"
  os_sku = "${var.os_sku}"
  os_version = "${var.os_version}"
  username = "${var.username}"
  ssh-key = "${var.ssh-key}"
  subnet_id = "${module.azure-network.subnet_id}"

}
