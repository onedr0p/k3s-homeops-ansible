variable "rg_name" {
  default = "k3s-bootstrap"
}

variable "hosts" {
  description = "Key-Value of VM Names to Type"
  default = {
    "k3s-bootstrap-0" = {
      "name"    = "k3s-bootstrap-0",
      "type"    = "master",
      "storage" = "nfs",
      "ceph"    = "false",
      "nfs"     = "false"
    },
    "k3s-bootstrap-1" = {
      "name"    = "k3s-bootstrap-1",
      "type"    = "nodes",
      "storage" = "ceph",
      "ceph"    = "true",
      "nfs"     = "false"
    },
    "k3s-bootstrap-2" = {
      "name"    = "k3s-bootstrap-2",
      "type"    = "nodes",
      "storage" = "ceph",
      "ceph"    = "true",
      "nfs"     = "false"
    },
    "k3s-bootstrap-3" = {
      "name"    = "k3s-bootstrap-3",
      "type"    = "nodes",
      "storage" = "ceph",
      "ceph"    = "true",
      "nfs"     = "true"
    }
  }
}

variable "rg_network_name" {
  default = "k3s-bootstrap"
}

variable "vnet_address_space" {
  default = ["10.20.0.0/16"]
}

variable "vnet_name" {
  default = "k3s-bootstrap-vnet"
}

variable "vnet_subnet_name" {
  default = "default"
}

variable "vnet_subnet_prefix" {
  default = "10.20.0.0/16"
}

variable "vnet_parent_rg_name" {
  default = "RG_Networking"
}

variable "vnet_parent_name" {
  default = "vNET_EAST"
}

variable "location" {
  default = "eastus2"
}

variable "username" {
  default = "ryan"
}

variable "ssh_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC89TmUQA/42oqlTv8V+DnSENLEIg+nxAJ91Yvyhr3jDp9bt+AgtSuBzxvEqBqAnclfnnou5M2fWxV09H5bVZvM0J+gT8n9GNQCU6XjAfajJCs9YdvY7SVfcxI3GcN8WF6iIiadzpnQmF1Qn7qxe4kOZCyF1Fg2kMTs8cBuCiNQdQefiaMkPbzp1YtNAtB6lJpoL0Eqdubq/SA9KVKyLgs9SqYEei+pvug/h96/Kz5KBN6Oe5ROqgyLoQ6yLhDiFVNAG7pRBJWhlT3bXF6h5FtOoqxijw1uKQipu5/9Ejm/TaiU34phj4g5UF8RRoPTNs9eIszXdCWOQDxWH1RAXBPTnwgZ+5Tm7/Nblzc925a5oiEllN0drVH0G2fOfBd0THke/rPni0uf4TuE2qOmDCAdIUfbVuelJuu4SGiL96yuepkLfXu5uECX2Z2rE+SDU6yQ3QGbZx6n1oeLznh0Vf8PkwxXRkiqmYuD1BEcRpCMwM4QBhTnmAMgxUoFu/F0/K3FUK1Psfse0EVilZlPHWr080yh0mM5+FGqiv3kbW0gkHCfoMBeJUTMTQXGnaJEkWSfnkUHum+Ob73d27kOZjKUB/30vCcFj6tWOCFZYxYizrCopYeKhc+NWV5S2loz3E8KJyI8R1/z8cMElibFXSDxuySx0t28TlazvXEwGpfzTw=="
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
