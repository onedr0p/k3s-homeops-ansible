output "ip_addresses" {
  value = [azurerm_public_ip.k3s-bootstrap-publicip]
}
