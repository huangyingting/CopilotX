# Networking Module
# Creates Virtual Network and required subnets

# Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = "${var.vnet_name}-${var.environment}"
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = merge(var.tags, {
    Name        = "${var.vnet_name}-${var.environment}"
    Environment = var.environment
  })
}

# AKS Subnet
resource "azurerm_subnet" "aks" {
  name                 = "snet-aks-${var.environment}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.aks_subnet_address_prefixes
}

# Application Gateway Subnet
resource "azurerm_subnet" "app_gateway" {
  name                 = "snet-appgw-${var.environment}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.app_gateway_subnet_address_prefixes
}