# Monitoring Module
# Creates Log Analytics Workspace and Application Insights

# Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "main" {
  name                = "${var.log_analytics_workspace_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.log_analytics_sku
  retention_in_days   = var.log_analytics_retention_days

  tags = merge(var.tags, {
    Name        = "${var.log_analytics_workspace_name}-${var.environment}"
    Environment = var.environment
  })
}

# Application Insights
resource "azurerm_application_insights" "main" {
  name                = "${var.application_insights_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  workspace_id        = azurerm_log_analytics_workspace.main.id
  application_type    = var.application_insights_type

  tags = merge(var.tags, {
    Name        = "${var.application_insights_name}-${var.environment}"
    Environment = var.environment
  })
}