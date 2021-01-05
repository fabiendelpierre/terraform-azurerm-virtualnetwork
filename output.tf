output "vnet_name" {
  value = azurerm_virtual_network.msdn.name
}

output "vnet_id" {
  value = azurerm_virtual_network.msdn.id
}

output "subnet_name" {
  value = azurerm_subnet.msdn1.name
}

output "subnet_id" {
  value = azurerm_subnet.msdn1.id
}

output "nsg_name" {
  value = azurerm_network_security_group.msdn1.name
}

output "nsg_id" {
  value = azurerm_network_security_group.msdn1.id
}