# Azure Infrastructure Module

This is a self-contained, reusable Terraform module for deploying a complete Azure infrastructure stack. The module creates all the necessary Azure resources for a modern cloud-native application including AKS, databases, monitoring, and networking components.

## Resources Created

### Core Infrastructure
- **Resource Group** - Container for all resources
- **Virtual Network** with dedicated subnets for AKS and Application Gateway
- **Azure Kubernetes Service (AKS)** cluster with auto-scaling
- **Azure Container Registry (ACR)** for container image storage
- **Azure Application Gateway** for load balancing and ingress

### Data Services
- **Azure SQL Database** with firewall configuration
- **Azure Cosmos DB** with SQL API
- **Azure Key Vault** for secrets management

### Monitoring & Observability
- **Azure Monitor** with Log Analytics workspace
- **Application Insights** for application performance monitoring

## Usage

```hcl
module "azure_infrastructure" {
  source = "./modules/azure-infrastructure"

  # Required variables
  sql_admin_password = var.sql_admin_password

  # Optional variables (with defaults)
  environment         = "dev"
  location           = "East US"
  resource_group_name = "rg-copilotx"
  cluster_name       = "aks-copilotx"
  
  # Additional configuration...
}
```

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| sql_admin_password | Administrator password for SQL Server | `string` | n/a | yes |
| environment | Environment name (e.g., dev, staging, prod) | `string` | `"dev"` | no |
| location | Azure region for resources | `string` | `"East US"` | no |
| resource_group_name | Name of the resource group | `string` | `"rg-copilotx"` | no |
| cluster_name | Name of the AKS cluster | `string` | `"aks-copilotx"` | no |
| node_count | Number of nodes in the AKS cluster | `number` | `3` | no |
| node_size | Size of AKS cluster nodes | `string` | `"Standard_DS2_v2"` | no |
| kubernetes_version | Kubernetes version for AKS cluster | `string` | `"1.28"` | no |
| acr_name | Name of the Azure Container Registry | `string` | `"acrcopilotx"` | no |
| acr_sku | SKU for Azure Container Registry | `string` | `"Standard"` | no |
| key_vault_name | Name of the Azure Key Vault | `string` | `"kv-copilotx"` | no |
| sql_server_name | Name of the SQL Server | `string` | `"sql-copilotx"` | no |
| sql_database_name | Name of the SQL Database | `string` | `"sqldb-copilotx"` | no |
| sql_admin_username | Administrator username for SQL Server | `string` | `"sqladmin"` | no |
| cosmosdb_account_name | Name of the Cosmos DB account | `string` | `"cosmos-copilotx"` | no |
| cosmosdb_database_name | Name of the Cosmos DB database | `string` | `"cosmosdb-copilotx"` | no |
| log_analytics_workspace_name | Name of the Log Analytics workspace | `string` | `"law-copilotx"` | no |
| application_insights_name | Name of the Application Insights instance | `string` | `"ai-copilotx"` | no |
| vnet_name | Name of the virtual network | `string` | `"vnet-copilotx"` | no |
| vnet_address_space | Address space for the virtual network | `list(string)` | `["10.0.0.0/16"]` | no |
| aks_subnet_address_prefixes | Address prefixes for AKS subnet | `list(string)` | `["10.0.1.0/24"]` | no |
| app_gateway_subnet_address_prefixes | Address prefixes for Application Gateway subnet | `list(string)` | `["10.0.2.0/24"]` | no |
| enable_auto_scaling | Enable auto scaling for AKS cluster | `bool` | `true` | no |
| min_node_count | Minimum number of nodes for auto scaling | `number` | `1` | no |
| max_node_count | Maximum number of nodes for auto scaling | `number` | `10` | no |
| tags | Tags to apply to all resources | `map(string)` | `{"ManagedBy" = "Terraform", "Project" = "CopilotX"}` | no |

## Outputs

| Name | Description |
|------|-------------|
| resource_group_name | Name of the resource group |
| resource_group_location | Location of the resource group |
| aks_cluster_name | Name of the AKS cluster |
| aks_cluster_id | ID of the AKS cluster |
| aks_cluster_fqdn | FQDN of the AKS cluster |
| aks_cluster_endpoint | Endpoint for the AKS cluster |
| aks_cluster_ca_certificate | CA certificate for the AKS cluster (sensitive) |
| aks_cluster_client_certificate | Client certificate for the AKS cluster (sensitive) |
| aks_cluster_client_key | Client key for the AKS cluster (sensitive) |
| acr_name | Name of the Azure Container Registry |
| acr_login_server | Login server URL for the Azure Container Registry |
| acr_admin_username | Admin username for the Azure Container Registry |
| acr_admin_password | Admin password for the Azure Container Registry (sensitive) |
| key_vault_name | Name of the Key Vault |
| key_vault_uri | URI of the Key Vault |
| sql_server_name | Name of the SQL Server |
| sql_server_fqdn | Fully qualified domain name of the SQL Server |
| sql_database_name | Name of the SQL Database |
| cosmosdb_account_name | Name of the Cosmos DB account |
| cosmosdb_endpoint | Endpoint for the Cosmos DB account |
| cosmosdb_primary_key | Primary key for the Cosmos DB account (sensitive) |
| cosmosdb_database_name | Name of the Cosmos DB database |
| application_gateway_name | Name of the Application Gateway |
| application_gateway_public_ip | Public IP address of the Application Gateway |
| application_gateway_fqdn | FQDN of the Application Gateway |
| vnet_name | Name of the virtual network |
| vnet_id | ID of the virtual network |
| aks_subnet_id | ID of the AKS subnet |
| log_analytics_workspace_name | Name of the Log Analytics workspace |
| log_analytics_workspace_id | ID of the Log Analytics workspace |
| application_insights_name | Name of the Application Insights instance |
| application_insights_instrumentation_key | Instrumentation key for Application Insights (sensitive) |
| application_insights_connection_string | Connection string for Application Insights (sensitive) |

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| azurerm | ~> 3.0 |
| azuread | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | ~> 3.0 |
| azuread | ~> 2.0 |

## Security Features

- **Service Principal authentication** with minimal required permissions
- **Azure Key Vault integration** for secrets management
- **RBAC configuration** for AKS cluster access
- **Network security** with dedicated subnets and security groups
- **Automated secret storage** for connection strings and credentials

## Notes

- This module creates resources that may incur costs in your Azure subscription
- The AKS cluster is configured with auto-scaling enabled by default (1-10 nodes)
- All sensitive outputs are marked as sensitive and will not be displayed in Terraform output
- Connection strings and credentials are automatically stored in Key Vault
- The module includes proper RBAC configuration for AKS to access ACR