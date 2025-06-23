# Outputs from Azure Infrastructure Terraform Module
# All created resource identifiers are exposed as outputs for external use

# Resource Group Module Outputs
output "resource_group_name" {
  description = "Name of the resource group"
  value       = module.resource_group.resource_group_name
}

output "resource_group_location" {
  description = "Location of the resource group"
  value       = module.resource_group.resource_group_location
}

output "resource_group_id" {
  description = "ID of the resource group"
  value       = module.resource_group.resource_group_id
}

# Networking Module Outputs
output "vnet_id" {
  description = "ID of the virtual network"
  value       = module.networking.vnet_id
}

output "vnet_name" {
  description = "Name of the virtual network"
  value       = module.networking.vnet_name
}

output "aks_subnet_id" {
  description = "ID of the AKS subnet"
  value       = module.networking.aks_subnet_id
}

output "app_gateway_subnet_id" {
  description = "ID of the Application Gateway subnet"
  value       = module.networking.app_gateway_subnet_id
}

# AKS Module Outputs
output "aks_cluster_name" {
  description = "Name of the AKS cluster"
  value       = module.aks.aks_name
}

output "aks_cluster_id" {
  description = "ID of the AKS cluster"
  value       = module.aks.aks_id
}

output "aks_cluster_fqdn" {
  description = "FQDN of the AKS cluster"
  value       = module.aks.aks_fqdn
}

output "aks_cluster_endpoint" {
  description = "Endpoint for the AKS cluster"
  value       = module.aks.host
}

output "aks_cluster_ca_certificate" {
  description = "CA certificate for the AKS cluster"
  value       = module.aks.cluster_ca_certificate
  sensitive   = true
}

output "aks_cluster_client_certificate" {
  description = "Client certificate for the AKS cluster"
  value       = module.aks.client_certificate
  sensitive   = true
}

output "aks_cluster_client_key" {
  description = "Client key for the AKS cluster"
  value       = module.aks.client_key
  sensitive   = true
}

output "kube_config" {
  description = "Kube config for the AKS cluster"
  value       = module.aks.kube_config
  sensitive   = true
}

output "aks_node_resource_group" {
  description = "Node resource group name of the AKS cluster"
  value       = module.aks.aks_node_resource_group
}

# ACR Module Outputs
output "acr_id" {
  description = "ID of the Azure Container Registry"
  value       = module.acr.acr_id
}

output "acr_name" {
  description = "Name of the Azure Container Registry"
  value       = module.acr.acr_name
}

output "acr_login_server" {
  description = "Login server URL of the Azure Container Registry"
  value       = module.acr.acr_login_server
}

output "acr_admin_username" {
  description = "Admin username of the Azure Container Registry"
  value       = module.acr.acr_admin_username
}

output "acr_admin_password" {
  description = "Admin password of the Azure Container Registry"
  value       = module.acr.acr_admin_password
  sensitive   = true
}

# Key Vault Module Outputs
output "key_vault_id" {
  description = "ID of the Key Vault"
  value       = module.key_vault.key_vault_id
}

output "key_vault_name" {
  description = "Name of the Key Vault"
  value       = module.key_vault.key_vault_name
}

output "key_vault_uri" {
  description = "URI of the Key Vault"
  value       = module.key_vault.key_vault_uri
}

# SQL Database Module Outputs
output "sql_server_id" {
  description = "ID of the SQL Server"
  value       = module.sql_database.sql_server_id
}

output "sql_server_name" {
  description = "Name of the SQL Server"
  value       = module.sql_database.sql_server_name
}

output "sql_server_fqdn" {
  description = "Fully qualified domain name of the SQL Server"
  value       = module.sql_database.sql_server_fqdn
}

output "sql_database_id" {
  description = "ID of the SQL Database"
  value       = module.sql_database.sql_database_id
}

output "sql_database_name" {
  description = "Name of the SQL Database"
  value       = module.sql_database.sql_database_name
}

output "sql_connection_string" {
  description = "Connection string for the SQL Database"
  value       = module.sql_database.sql_connection_string
  sensitive   = true
}

# Cosmos DB Module Outputs
output "cosmosdb_account_id" {
  description = "ID of the Cosmos DB account"
  value       = module.cosmos_db.cosmosdb_account_id
}

output "cosmosdb_account_name" {
  description = "Name of the Cosmos DB account"
  value       = module.cosmos_db.cosmosdb_account_name
}

output "cosmosdb_account_endpoint" {
  description = "Endpoint of the Cosmos DB account"
  value       = module.cosmos_db.cosmosdb_account_endpoint
}

output "cosmosdb_account_primary_key" {
  description = "Primary key of the Cosmos DB account"
  value       = module.cosmos_db.cosmosdb_account_primary_key
  sensitive   = true
}

output "cosmosdb_database_id" {
  description = "ID of the Cosmos DB SQL database"
  value       = module.cosmos_db.cosmosdb_database_id
}

output "cosmosdb_database_name" {
  description = "Name of the Cosmos DB SQL database"
  value       = module.cosmos_db.cosmosdb_database_name
}

output "cosmosdb_connection_string" {
  description = "Connection string for the Cosmos DB account"
  value       = module.cosmos_db.cosmosdb_connection_string
  sensitive   = true
}

# Application Gateway Module Outputs
output "application_gateway_id" {
  description = "ID of the Application Gateway"
  value       = module.application_gateway.application_gateway_id
}

output "application_gateway_name" {
  description = "Name of the Application Gateway"
  value       = module.application_gateway.application_gateway_name
}

output "application_gateway_public_ip_address" {
  description = "IP address of the Application Gateway public IP"
  value       = module.application_gateway.public_ip_address
}

# Monitoring Module Outputs
output "log_analytics_workspace_id" {
  description = "ID of the Log Analytics workspace"
  value       = module.monitoring.log_analytics_workspace_id
}

output "log_analytics_workspace_name" {
  description = "Name of the Log Analytics workspace"
  value       = module.monitoring.log_analytics_workspace_name
}

output "application_insights_id" {
  description = "ID of the Application Insights instance"
  value       = module.monitoring.application_insights_id
}

output "application_insights_name" {
  description = "Name of the Application Insights instance"
  value       = module.monitoring.application_insights_name
}

output "application_insights_instrumentation_key" {
  description = "Instrumentation key of the Application Insights instance"
  value       = module.monitoring.application_insights_instrumentation_key
  sensitive   = true
}

output "application_insights_connection_string" {
  description = "Connection string of the Application Insights instance"
  value       = module.monitoring.application_insights_connection_string
  sensitive   = true
}
  sensitive   = true
}

# Container Registry
output "acr_name" {
  description = "Name of the Azure Container Registry"
  value       = azurerm_container_registry.main.name
}

output "acr_login_server" {
  description = "Login server URL for the Azure Container Registry"
  value       = azurerm_container_registry.main.login_server
}

output "acr_admin_username" {
  description = "Admin username for the Azure Container Registry"
  value       = azurerm_container_registry.main.admin_username
}

output "acr_admin_password" {
  description = "Admin password for the Azure Container Registry"
  value       = azurerm_container_registry.main.admin_password
  sensitive   = true
}

# Key Vault
output "key_vault_name" {
  description = "Name of the Key Vault"
  value       = azurerm_key_vault.main.name
}

output "key_vault_uri" {
  description = "URI of the Key Vault"
  value       = azurerm_key_vault.main.vault_uri
}

# SQL Server and Database
output "sql_server_name" {
  description = "Name of the SQL Server"
  value       = azurerm_mssql_server.main.name
}

output "sql_server_fqdn" {
  description = "Fully qualified domain name of the SQL Server"
  value       = azurerm_mssql_server.main.fully_qualified_domain_name
}

output "sql_database_name" {
  description = "Name of the SQL Database"
  value       = azurerm_mssql_database.main.name
}

# Cosmos DB
output "cosmosdb_account_name" {
  description = "Name of the Cosmos DB account"
  value       = azurerm_cosmosdb_account.main.name
}

output "cosmosdb_endpoint" {
  description = "Endpoint for the Cosmos DB account"
  value       = azurerm_cosmosdb_account.main.endpoint
}

output "cosmosdb_primary_key" {
  description = "Primary key for the Cosmos DB account"
  value       = azurerm_cosmosdb_account.main.primary_key
  sensitive   = true
}

output "cosmosdb_database_name" {
  description = "Name of the Cosmos DB database"
  value       = azurerm_cosmosdb_sql_database.main.name
}

# Application Gateway
output "application_gateway_name" {
  description = "Name of the Application Gateway"
  value       = azurerm_application_gateway.main.name
}

output "application_gateway_public_ip" {
  description = "Public IP address of the Application Gateway"
  value       = azurerm_public_ip.app_gateway.ip_address
}

output "application_gateway_fqdn" {
  description = "FQDN of the Application Gateway"
  value       = azurerm_public_ip.app_gateway.fqdn
}

# Virtual Network
output "vnet_name" {
  description = "Name of the virtual network"
  value       = azurerm_virtual_network.main.name
}

output "vnet_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.main.id
}

output "aks_subnet_id" {
  description = "ID of the AKS subnet"
  value       = azurerm_subnet.aks.id
}

# Monitoring
output "log_analytics_workspace_name" {
  description = "Name of the Log Analytics workspace"
  value       = azurerm_log_analytics_workspace.main.name
}

output "log_analytics_workspace_id" {
  description = "ID of the Log Analytics workspace"
  value       = azurerm_log_analytics_workspace.main.id
}

output "application_insights_name" {
  description = "Name of the Application Insights instance"
  value       = azurerm_application_insights.main.name
}

output "application_insights_instrumentation_key" {
  description = "Instrumentation key for Application Insights"
  value       = azurerm_application_insights.main.instrumentation_key
  sensitive   = true
}

output "application_insights_connection_string" {
  description = "Connection string for Application Insights"
  value       = azurerm_application_insights.main.connection_string
  sensitive   = true
}