variable "rg_name" {
  default = "k3s-bootstrap"
}

variable "names" {
  default = ["k3s-0","k3s-1","k3s-2"]
}

variable "rg_network_name" {
  default = "k3s-bootstrap"
}

variable "vnet_address_space" {
  default = ["172.16.12.0/22"]
}

variable "vnet_name" {
  default = "k3s-bootstrap-vnet"
}

variable "vnet_subnet_name" {
  default = "default"
}

variable "vnet_subnet_prefix" {
  default = "172.16.12.0/24"
}

variable "vnet_parent_rg_name" {
  default = "RG_Networking"
}

variable "vnet_parent_name" {
  default = "vNET_EAST"
}

# Comes from Environment Variable, sensitive :)
variable "vnet_parent_id" {
}

variable "location" {
  default = "eastus2"
}

variable "username" {
  default = "ryan"
}

variable "ssh-key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCwK/RgEkR8ZpOF3TuqZwDpyCQqz7DxZfiPNV/T/6zDqgEK6eAIKVtPnL4gY6Uc0Ym3Xa7WJ3uLtN1OE/4bQimSrKOjgc4x1hIfrbFNecdyA2k9oHcIVaAW3iKmWpuK/KwUhXPAB7J6UJaD1CB9Fg5tnbHUmj1bpRqrFImIyWoZT8oPH12iI7fv5N/DMFolgSG6XxVB9yuhhascYzBk6x5O8lF7Hm4gWFo4uRkDTHiKSfDKtUt2NTPDl6qFHtOlvovZEudzkzJgME0ikfCU7ckWlvyLDPPXP0R6Z4bhns3pS9tvjiMVctRgft4MW+Q9IBvnR9Nek/jdViYKQfduz7se+LLwe8eVcDLzqo95N/Z2qLh8w+Ew2ORFcjujBwGtL2hFwB0d7/9Ua5tMifbRWGyseRdjxuPzc2zbFfPzx9uIGTX/lJsvPbzlPdqGO4QM2HdWoOoriIjU4qk5QP2zpMqvNvc6vQ+2or42I6MtFySE6OUlNrvS487EPzAKgweb+OE= ryan@rynux"
}

variable "os_publisher" {
  default = "canonical"
}

variable "os_offer" {
  default = "0001-com-ubuntu-server-eoan"
}

variable "os_sku" {
  default = "19_10"
}

variable "os_version" {
  default = "latest"
}

variable vm_size {
  default = "Standard_D2S_v3"
}
