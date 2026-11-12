provider "azurerm" {
  features {}
}

module "network" {
  source = "../../"

  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = var.vnet_name
  vnet_address_space  = var.vnet_address_space
  subnet_name         = var.subnet_name
  subnet_prefixes     = var.subnet_prefixes
}
