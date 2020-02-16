resource "azurerm_public_ip" "k3s-bootstrap-publicip" {
  count                             =       var.vm_count
  name                              =       "${var.name_prefix}-${count.index}-ip"
  location                          =       var.location
  resource_group_name               =       var.rg_name
  allocation_method                 =       "Dynamic"
}

resource "azurerm_network_security_group" "k3s-bootstrap-nsg" {
  name                              =       "k3s-bootstrap"
  location                          =       var.location
  resource_group_name               =       var.rg_name

  security_rule {
    name                            =       "SSH"
    priority                        =       1001
    direction                       =       "Inbound"
    access                          =       "Allow"
    protocol                        =       "Tcp"
    source_port_range               =       "*"
    destination_port_range          =       "22"
    source_address_prefix            =       "*"
    destination_address_prefix       =       "*"
  }
}

resource "azurerm_network_interface" "k3s-bootstrap-nic" {
  count                             =       var.vm_count
  name                              =       "${var.name_prefix}-${count.index}-nic"
  location                          =       var.location
  resource_group_name               =       var.rg_name
  network_security_group_id         =       azurerm_network_security_group.k3s-bootstrap-nsg.id

  ip_configuration {
    name                            =       "${var.name_prefix}-${count.index}-nic-configuration"
    subnet_id                       =       var.subnet_id
    private_ip_address_allocation   =       "Dynamic"
    public_ip_address_id            =       azurerm_public_ip.k3s-bootstrap-publicip[count.index].id
  }
}

resource "azurerm_virtual_machine" "k3s-bootstrap-vm" {
  count                             =       var.vm_count
  name                              =       "${var.name_prefix}-${count.index}"
  location                          =       var.location
  resource_group_name               =       var.rg_name
  network_interface_ids             =       [azurerm_network_interface.k3s-bootstrap-nic[count.index].id]
  vm_size                           =       var.vm_size
  storage_os_disk {
    name                            =       "${var.name_prefix}-${count.index}-OS"
    caching                         =       "ReadWrite"
    create_option                   =       "FromImage"
    managed_disk_type               =       "Premium_LRS"
  }

  storage_image_reference {
    publisher                       =       var.os_publisher
    offer                           =       var.os_offer
    sku                             =       var.os_sku
    version                         =       var.os_version
  }

  os_profile {
    computer_name                   =       "${var.name_prefix}-${count.index}"
    admin_username                  =       var.username
  }

  os_profile_linux_config {
    disable_password_authentication =       true
    ssh_keys {
      path                          =       "/home/${var.username}/.ssh/authorized_keys"
      key_data                      =       var.ssh-key
    }
  }
  tags = {
    type = "${count.index == 0 ? "master" : "nodes"}"
  }
}

