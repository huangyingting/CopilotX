# Cosmos DB Module
# Creates Azure Cosmos DB account and SQL database

# Cosmos DB Account
resource "azurerm_cosmosdb_account" "main" {
  name                = "${var.cosmosdb_account_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = var.offer_type
  kind                = var.cosmos_kind

  consistency_policy {
    consistency_level = var.consistency_level
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }

  tags = merge(var.tags, {
    Name        = "${var.cosmosdb_account_name}-${var.environment}"
    Environment = var.environment
  })
}

# Cosmos DB SQL Database
resource "azurerm_cosmosdb_sql_database" "main" {
  name                = "${var.cosmosdb_database_name}-${var.environment}"
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.main.name
}