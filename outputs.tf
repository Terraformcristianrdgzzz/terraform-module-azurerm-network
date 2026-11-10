output "resource_group_name" {
  description = "Name of the resource group containing the network resources."
  value       = var.resource_group_name
}

output "vnet_id" {
  description = "ID of the virtual network."
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "Name of the virtual network."
  value       = azurerm_virtual_network.vnet.name
}

output "subnet_id" {
  description = "ID of the subnet."
  value       = azurerm_subnet.subnet.id
}

output "subnet_name" {
  description = "Name of the subnet."
  value       = azurerm_subnet.subnet.name
}
