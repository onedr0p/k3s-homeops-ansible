output "ip_addresses" {
  value = [azurerm_network_interface.k3s-bootstrap-nic]
}
