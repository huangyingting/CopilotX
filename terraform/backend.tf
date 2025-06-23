# Terraform Backend Configuration
# This file configures remote state storage in Azure Storage Account

terraform {
  backend "azurerm" {
    # These values will be provided via CLI or environment variables
    # resource_group_name  = "rg-terraform-state"
    # storage_account_name = "tfstatestorage"
    # container_name       = "tfstate"
    # key                  = "terraform.tfstate"
  }
}

# To initialize with backend, run:
# terraform init \
#   -backend-config="resource_group_name=rg-terraform-state" \
#   -backend-config="storage_account_name=tfstatestorage" \
#   -backend-config="container_name=tfstate" \
#   -backend-config="key=terraform.tfstate"