resource "azurerm_virtual_network" "msdn" {
  name                = "${var.base_name}-vnet"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = [var.vnet_cidr]

  tags = var.tags
}

resource "azurerm_subnet" "msdn1" {
  name                  = "${var.base_name}-vnet-subnet1"
  resource_group_name   = data.azurerm_resource_group.rg.name
  virtual_network_name  = azurerm_virtual_network.msdn.name
  address_prefixes      = [cidrsubnet(var.vnet_cidr, 2, 0)]
  service_endpoints     = [
    "Microsoft.AzureActiveDirectory",
    "Microsoft.ContainerRegistry",
    "Microsoft.KeyVault",
    "Microsoft.Sql",
    "Microsoft.Storage",
  ]
}

resource "azurerm_network_security_group" "msdn1" {
  name                = "${azurerm_subnet.msdn1.name}-nsg"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location

  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "msdn1" {
  subnet_id                 = azurerm_subnet.msdn1.id
  network_security_group_id = azurerm_network_security_group.msdn1.id
}

resource "azurerm_network_security_rule" "inbound_deny_all" {
  resource_group_name         = data.azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.msdn1.name

  name = "inbound-deny-all"

  priority                    = 4096
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_address_prefix       = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "*"
}

resource "azurerm_network_security_rule" "outbound_deny_all" {
  resource_group_name         = data.azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.msdn1.name

  name = "outbound-deny-all"

  priority                    = 4096
  direction                   = "Outbound"
  access                      = "Deny"
  protocol                    = "*"
  source_address_prefix       = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "*"
}

resource "azurerm_network_security_group" "msdn2" {
  name                = "${azurerm_subnet.msdn1.name}-nsg"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location

  tags = var.tags
}