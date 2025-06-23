# Root Terraform configuration that uses the azure-infrastructure module
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

# Use the azure-infrastructure module
module "azure_infrastructure" {
  source = "./modules/azure-infrastructure"

  # Required variables
  sql_admin_password = var.sql_admin_password

  # Optional variables (can override defaults)
  environment                         = var.environment
  location                           = var.location
  resource_group_name                = var.resource_group_name
  cluster_name                       = var.cluster_name
  node_count                         = var.node_count
  node_size                          = var.node_size
  kubernetes_version                 = var.kubernetes_version
  acr_name                          = var.acr_name
  acr_sku                           = var.acr_sku
  key_vault_name                    = var.key_vault_name
  sql_server_name                   = var.sql_server_name
  sql_database_name                 = var.sql_database_name
  sql_admin_username                = var.sql_admin_username
  cosmosdb_account_name             = var.cosmosdb_account_name
  cosmosdb_database_name            = var.cosmosdb_database_name
  log_analytics_workspace_name      = var.log_analytics_workspace_name
  application_insights_name         = var.application_insights_name
  vnet_name                         = var.vnet_name
  vnet_address_space                = var.vnet_address_space
  aks_subnet_address_prefixes       = var.aks_subnet_address_prefixes
  app_gateway_subnet_address_prefixes = var.app_gateway_subnet_address_prefixes
  enable_auto_scaling               = var.enable_auto_scaling
  min_node_count                    = var.min_node_count
  max_node_count                    = var.max_node_count
  tags                              = var.tags
}

# Configure Helm and Kubernetes providers using outputs from the module
provider "helm" {
  kubernetes {
    host                   = module.azure_infrastructure.aks_cluster_endpoint
    client_certificate     = base64decode(module.azure_infrastructure.aks_cluster_client_certificate)
    client_key             = base64decode(module.azure_infrastructure.aks_cluster_client_key)
    cluster_ca_certificate = base64decode(module.azure_infrastructure.aks_cluster_ca_certificate)
  }
}

provider "kubernetes" {
  host                   = module.azure_infrastructure.aks_cluster_endpoint
  client_certificate     = base64decode(module.azure_infrastructure.aks_cluster_client_certificate)
  client_key             = base64decode(module.azure_infrastructure.aks_cluster_client_key)
  cluster_ca_certificate = base64decode(module.azure_infrastructure.aks_cluster_ca_certificate)
}