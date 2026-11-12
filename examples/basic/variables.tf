variable "resource_group_name" {
  description = "Name of an existing resource group."
  type        = string
}

variable "location" {
  description = "Azure region for the network."
  type        = string
}

variable "vnet_name" {
  description = "Virtual network name."
  type        = string
}

variable "vnet_address_space" {
  description = "IPv4 CIDR address space for the virtual network."
  type        = list(string)
}

variable "subnet_name" {
  description = "Subnet name."
  type        = string
}

variable "subnet_prefixes" {
  description = "IPv4 CIDR prefixes for the subnet."
  type        = list(string)
}
