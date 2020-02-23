variable "hosts" {
  description = "Key-Value of VM Names to Type"
  type        = map
}

variable "location" {
  description = "Azure Location where resources will be deployed"
  type        = string
}

variable "rg_name" {
  description = "Resource Group where resources will be deployed"
  type        = string
}

variable "vm_size" {
  description = "VM Size to be used for deployment"
  type        = string
}

variable "os_publisher" {
  description = "Azure Marketplace OS Image Publisher"
  type        = string
}

variable "os_offer" {
  description = "Azure Marketplace OS Image Offer"
  type        = string
}

variable "os_sku" {
  description = "Azure Marketplace OS Image SKU"
  type        = string
}

variable "os_version" {
  description = "Azure Marketplace OS Image Version"
  type        = string
}

variable "username" {
  description = "Admin User on deployed system"
  type        = string
}

variable "ssh_key" {
  description = "SSH Key for Admin User"
  type        = string
}

variable "subnet_id" {
  description = "Azure Subnet ID for VM's NIC to join"
  type        = string
}
