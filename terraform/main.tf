# Azure Infrastructure Terraform Configuration
# Modular Terraform configuration using reusable modules for each Azure service
terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }

  # Terraform Backend Configuration
  # This file configures remote state storage in Azure Storage Account
  backend "azurerm" {
    # These values will be provided via CLI or environment variables
    # resource_group_name  = "rg-terraform-state"
    # storage_account_name = "tfstatestorage"
    # container_name       = "tfstate"
    # key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

provider "azuread" {}

# Data sources
data "azurerm_client_config" "current" {}

data "azuread_client_config" "current" {}

# Module calls for each Azure service component

# Resource Group Module
module "resource_group" {
  source = "./modules/resource_group"

  resource_group_name = var.resource_group_name
  environment         = var.environment
  location            = var.location
  tags                = var.tags
}

# Networking Module
module "networking" {
  source = "./modules/networking"

  vnet_name                           = var.vnet_name
  environment                         = var.environment
  location                            = var.location
  resource_group_name                 = module.resource_group.resource_group_name
  vnet_address_space                  = var.vnet_address_space
  aks_subnet_address_prefixes         = var.aks_subnet_address_prefixes
  app_gateway_subnet_address_prefixes = var.app_gateway_subnet_address_prefixes
  tags                                = var.tags

  depends_on = [module.resource_group]
}

# Monitoring Module
module "monitoring" {
  source = "./modules/monitoring"

  log_analytics_workspace_name = var.log_analytics_workspace_name
  application_insights_name     = var.application_insights_name
  environment                   = var.environment
  location                      = var.location
  resource_group_name           = module.resource_group.resource_group_name
  tags                          = var.tags

  depends_on = [module.resource_group]
}

# Azure Container Registry Module
module "acr" {
  source = "./modules/acr"

  acr_name            = var.acr_name
  environment         = var.environment
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  acr_sku             = var.acr_sku
  tags                = var.tags

  depends_on = [module.resource_group]
}

# AKS Cluster Module
module "aks" {
  source = "./modules/aks"

  cluster_name                   = var.cluster_name
  environment                    = var.environment
  location                       = var.location
  resource_group_name            = module.resource_group.resource_group_name
  kubernetes_version             = var.kubernetes_version
  node_count                     = var.node_count
  node_size                      = var.node_size
  aks_subnet_id                  = module.networking.aks_subnet_id
  enable_auto_scaling            = var.enable_auto_scaling
  min_node_count                 = var.min_node_count
  max_node_count                 = var.max_node_count
  log_analytics_workspace_id     = module.monitoring.log_analytics_workspace_id
  acr_id                         = module.acr.acr_id
  azure_policy_enabled           = var.azure_policy_enabled
  tags                           = var.tags

  depends_on = [module.resource_group, module.networking, module.monitoring, module.acr]
}

# Key Vault Module
module "key_vault" {
  source = "./modules/key_vault"

  key_vault_name          = var.key_vault_name
  environment             = var.environment
  location                = var.location
  resource_group_name     = module.resource_group.resource_group_name
  tenant_id               = data.azurerm_client_config.current.tenant_id
  current_user_object_id  = data.azurerm_client_config.current.object_id
  aks_principal_id        = module.aks.aks_identity_principal_id
  tags                    = var.tags

  depends_on = [module.resource_group, module.aks]
}

# SQL Database Module
module "sql_database" {
  source = "./modules/sql_database"

  sql_server_name     = var.sql_server_name
  sql_database_name   = var.sql_database_name
  environment         = var.environment
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  sql_admin_username  = var.sql_admin_username
  sql_admin_password  = var.sql_admin_password
  tags                = var.tags

  depends_on = [module.resource_group]
}

# Cosmos DB Module
module "cosmos_db" {
  source = "./modules/cosmos_db"

  cosmosdb_account_name  = var.cosmosdb_account_name
  cosmosdb_database_name = var.cosmosdb_database_name
  environment            = var.environment
  location               = var.location
  resource_group_name    = module.resource_group.resource_group_name
  tags                   = var.tags

  depends_on = [module.resource_group]
}

# Application Gateway Module
module "application_gateway" {
  source = "./modules/application_gateway"

  environment               = var.environment
  location                  = var.location
  resource_group_name       = module.resource_group.resource_group_name
  app_gateway_subnet_id     = module.networking.app_gateway_subnet_id
  tags                      = var.tags

  depends_on = [module.resource_group, module.networking]
}

# Store secrets in Key Vault
resource "azurerm_key_vault_secret" "sql_connection_string" {
  name         = "sql-connection-string"
  value        = module.sql_database.sql_connection_string
  key_vault_id = module.key_vault.key_vault_id
  
  depends_on = [module.key_vault, module.sql_database]
}

resource "azurerm_key_vault_secret" "cosmosdb_connection_string" {
  name         = "cosmosdb-connection-string"
  value        = module.cosmos_db.cosmosdb_connection_string
  key_vault_id = module.key_vault.key_vault_id
  
  depends_on = [module.key_vault, module.cosmos_db]
}

resource "azurerm_key_vault_secret" "acr_admin_password" {
  name         = "acr-admin-password"
  value        = module.acr.acr_admin_password
  key_vault_id = module.key_vault.key_vault_id
  
  depends_on = [module.key_vault, module.acr]
}

# Configure Helm and Kubernetes providers using the AKS cluster
provider "helm" {
  kubernetes {
    host                   = module.aks.host
    client_certificate     = base64decode(module.aks.client_certificate)
    client_key             = base64decode(module.aks.client_key)
    cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
  }
}

provider "kubernetes" {
  host                   = module.aks.host
  client_certificate     = base64decode(module.aks.client_certificate)
  client_key             = base64decode(module.aks.client_key)
  cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
}