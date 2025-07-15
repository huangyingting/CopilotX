# Azure Container Registry Module
# Creates Azure Container Registry for storing container images

resource "azurerm_container_registry" "main" {
  name                = "${var.acr_name}${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.acr_sku
  admin_enabled       = var.admin_enabled

  tags = merge(var.tags, {
    Name        = "${var.acr_name}-${var.environment}"
    Environment = var.environment
  })
}