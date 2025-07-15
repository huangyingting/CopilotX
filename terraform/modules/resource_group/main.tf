# Resource Group Module
# Creates the main resource group for all Azure resources

resource "azurerm_resource_group" "main" {
  name     = "${var.resource_group_name}-${var.environment}"
  location = var.location

  tags = merge(var.tags, {
    Name        = "${var.resource_group_name}-${var.environment}"
    Environment = var.environment
  })
}