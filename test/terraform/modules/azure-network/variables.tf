variable "location" {
  description = "Azure Location for resources to be deployed to"
  type = string
}

variable "rg_name" {
  description = "Resource Group containing all deployed objects"
  type = string
}

variable "vnet_address_space" {
  description = "Address Spaces for vNET"
  type = list(string)
}

variable "vnet_name" {
  description = "vNet Name"
  type = string
}

variable "vnet_subnet_name" {
  description = "Subnet Name"
  type = string
}

variable "vnet_subnet_prefix" {
  description = "Subnet Prefix"
  type = string
}

variable "vnet_parent_rg_name" {
  description = "RG name containing partner vNet to peer with"
  type = string
}

variable "vnet_parent_name" {
  description = "vNet name for partner vNet peer"
  type = string
}

variable "vnet_parent_id" {
  description = "ID for vNET to peer with"
  type = string
}
