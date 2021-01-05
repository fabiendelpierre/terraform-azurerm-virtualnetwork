output "vnet_id" {
  value = azurerm_virtual_network.msdn.id
}

output "subnet_id" {
  value = azurerm_subnet.msdn1.id
}

output "nsg_id" {
  value = azurerm_network_security_group.msdn1.id
}