variable "resource_group_name" {
  description = "Name of the existing resource group where the network resources will be created."
  type        = string

  validation {
    condition     = length(trimspace(var.resource_group_name)) > 0
    error_message = "resource_group_name must not be empty."
  }
}

variable "location" {
  description = "Azure region for the virtual network."
  type        = string

  validation {
    condition     = length(trimspace(var.location)) > 0
    error_message = "location must not be empty."
  }
}

variable "vnet_name" {
  description = "Name of the virtual network."
  type        = string

  validation {
    condition     = length(trimspace(var.vnet_name)) > 0
    error_message = "vnet_name must not be empty."
  }
}

variable "vnet_address_space" {
  description = "IPv4 CIDR address spaces assigned to the virtual network."
  type        = list(string)

  validation {
    condition     = length(var.vnet_address_space) > 0 && alltrue([for prefix in var.vnet_address_space : can(cidrnetmask(prefix))])
    error_message = "vnet_address_space must contain one or more valid IPv4 CIDR prefixes."
  }
}

variable "subnet_name" {
  description = "Name of the subnet."
  type        = string

  validation {
    condition     = length(trimspace(var.subnet_name)) > 0
    error_message = "subnet_name must not be empty."
  }
}

variable "subnet_prefixes" {
  description = "IPv4 CIDR address prefixes assigned to the subnet."
  type        = list(string)

  validation {
    condition     = length(var.subnet_prefixes) > 0 && alltrue([for prefix in var.subnet_prefixes : can(cidrnetmask(prefix))])
    error_message = "subnet_prefixes must contain one or more valid IPv4 CIDR prefixes."
  }
}
