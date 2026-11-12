resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space

  lifecycle {
    postcondition {
      condition     = self.name == var.vnet_name && toset(self.address_space) == toset(var.vnet_address_space)
      error_message = "Azure must create the virtual network with the configured name and address space."
    }
  }
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_prefixes

  lifecycle {
    precondition {
      condition     = local.subnet_prefixes_fit_vnet
      error_message = "Every subnet address prefix must be a correctly aligned subnet within one of the virtual network address spaces."
    }

    postcondition {
      condition     = toset(self.address_prefixes) == toset(var.subnet_prefixes)
      error_message = "Azure must assign the configured address prefixes to the subnet."
    }
  }
}
