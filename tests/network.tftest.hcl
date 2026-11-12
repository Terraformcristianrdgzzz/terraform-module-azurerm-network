mock_provider "azurerm" {
  mock_resource "azurerm_virtual_network" {
    defaults = {
      id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Network/virtualNetworks/vnet-test"
    }
  }

  mock_resource "azurerm_subnet" {
    defaults = {
      id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Network/virtualNetworks/vnet-test/subnets/snet-test"
    }
  }
}

variables {
  resource_group_name = "rg-test"
  location            = "East US"
  vnet_name           = "vnet-test"
  vnet_address_space  = ["10.10.0.0/16"]
  subnet_name         = "snet-test"
  subnet_prefixes     = ["10.10.1.0/24"]
}

run "network_outputs" {
  command = apply

  assert {
    condition     = output.resource_group_name == "rg-test"
    error_message = "The module must return the configured resource group name."
  }

  assert {
    condition     = output.vnet_name == "vnet-test" && output.subnet_name == "snet-test"
    error_message = "The module must return the configured virtual network and subnet names."
  }

  assert {
    condition     = output.vnet_id != "" && output.subnet_id != ""
    error_message = "The module must expose the virtual network and subnet IDs."
  }
}

run "rejects_invalid_vnet_cidr" {
  command = plan

  variables {
    vnet_address_space = ["not-a-cidr"]
  }

  expect_failures = [var.vnet_address_space]
}

run "rejects_empty_subnet_name" {
  command = plan

  variables {
    subnet_name = " "
  }

  expect_failures = [var.subnet_name]
}

run "rejects_invalid_subnet_cidr" {
  command = plan

  variables {
    subnet_prefixes = ["not-a-cidr"]
  }

  expect_failures = [var.subnet_prefixes]
}
