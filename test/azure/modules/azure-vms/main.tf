resource azurerm_public_ip "k3s-bootstrap-publicip" {
  for_each            = var.hosts
  name                = "${each.value.name}-ip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Dynamic"
}

resource azurerm_network_security_group "k3s-bootstrap-nsg" {
  name                = "k3s-bootstrap"
  location            = var.location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "K8S"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "6443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource azurerm_network_interface "k3s-bootstrap-nic" {
  for_each            = var.hosts
  name                = "${each.value.name}-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "${each.value.name}-nic-configuration"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.k3s-bootstrap-publicip[each.key].id
  }
}

resource "azurerm_network_interface_security_group_association" "k3s-bootstrap-nic-nsg" {
  for_each                  = var.hosts
  network_interface_id      = azurerm_network_interface.k3s-bootstrap-nic[each.key].id
  network_security_group_id = azurerm_network_security_group.k3s-bootstrap-nsg.id
}

resource azurerm_virtual_machine "k3s-bootstrap-vm" {
  for_each              = var.hosts
  name                  = each.value.name
  location              = var.location
  resource_group_name   = var.rg_name
  network_interface_ids = [azurerm_network_interface.k3s-bootstrap-nic[each.key].id]
  vm_size               = var.vm_size

  storage_os_disk {
    name              = "${each.value.name}-OS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  storage_data_disk {
    name              = "${each.value.name}-data"
    caching           = "ReadWrite"
    create_option     = "Empty"
    disk_size_gb      = 10
    lun               = 0
    managed_disk_type = "Premium_LRS"

  }

  storage_image_reference {
    publisher = var.os_publisher
    offer     = var.os_offer
    sku       = var.os_sku
    version   = var.os_version
  }

  os_profile {
    computer_name  = each.value.name
    admin_username = var.username
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/${var.username}/.ssh/authorized_keys"
      key_data = var.ssh_key
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    type    = each.value.type
    storage = each.value.storage
    nfs     = each.value.nfs
    ceph    = each.value.ceph
  }
}

resource azurerm_role_assignment "k3s-bootstrap-managed-identity-rbac-assignment" {
  for_each             = var.hosts
  scope                = var.rg_id
  role_definition_name = "Contributor"
  principal_id         = lookup(azurerm_virtual_machine.k3s-bootstrap-vm[each.key].identity[0], "principal_id")
}
