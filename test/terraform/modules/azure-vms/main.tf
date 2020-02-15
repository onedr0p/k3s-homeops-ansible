resource "azurerm_network_interface" "k3s-bootstrap-nic" {
  count                             =       length(var.names)
  name                              =       "${var.names[count.index]}-nic"
  location                          =       var.location
  resource_group_name               =       var.rg_name 

  ip_configuration {
    name                            =       "${var.names[count.index]}-nic-configuration"
    subnet_id                       =       var.subnet_id 
    private_ip_address_allocation   =       "Dynamic"
  }
}

resource "azurerm_virtual_machine" "k3s-bootstrap-vm" {
  count                             =       length(var.names)
  name                              =       var.names[count.index]
  location                          =       var.location
  resource_group_name               =       var.rg_name
  network_interface_ids             =       [azurerm_network_interface.k3s-bootstrap-nic[count.index].id]
  vm_size                           =       var.vm_size
  storage_os_disk {
    name                            =       "${var.names[count.index]}-OS"
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
    computer_name                   =       var.names[count.index]
    admin_username                  =       var.username
  }

  os_profile_linux_config {
    disable_password_authentication =       true
    ssh_keys {
      path                          =       "/home/${var.username}/.ssh/authorized_keys"
      key_data                      =       var.ssh-key
    }
  }
}
