# SQL Database Module
# Creates Azure SQL Server and Database

# SQL Server
resource "azurerm_mssql_server" "main" {
  name                         = "${var.sql_server_name}-${var.environment}"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = var.sql_server_version
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password

  tags = merge(var.tags, {
    Name        = "${var.sql_server_name}-${var.environment}"
    Environment = var.environment
  })
}

# SQL Database
resource "azurerm_mssql_database" "main" {
  name      = "${var.sql_database_name}-${var.environment}"
  server_id = azurerm_mssql_server.main.id
  sku_name  = var.sql_database_sku

  tags = merge(var.tags, {
    Name        = "${var.sql_database_name}-${var.environment}"
    Environment = var.environment
  })
}

# SQL Firewall Rule for Azure Services
resource "azurerm_mssql_firewall_rule" "azure_services" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.main.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}