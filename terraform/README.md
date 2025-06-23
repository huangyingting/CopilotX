# Azure Infrastructure Terraform Configuration

This Terraform configuration deploys a complete Azure infrastructure stack for the CopilotX project using **modular, reusable components**. Each Azure service is implemented as a separate module, making the configuration highly maintainable and reusable. The configuration includes AKS cluster, databases, monitoring, and networking components based on the provided architecture diagram.

## 🏗️ Infrastructure Components

### Core Azure Resources
- **Azure Kubernetes Service (AKS)** with auto-scaling node pools (1-10 nodes)
- **Azure Container Registry (ACR)** for container image storage
- **Azure Application Gateway** for load balancing and ingress
- **Azure Key Vault** for secrets management with proper access policies
- **Virtual Network** with dedicated subnets for AKS and Application Gateway

### Data Services
- **Azure SQL Database** for Service 1 with firewall rules
- **Azure Cosmos DB** with SQL API for Services 2 & 3
- Connection strings securely stored in Key Vault

### Monitoring & Observability
- **Azure Monitor** with Log Analytics workspace
- **Application Insights** for application performance monitoring

## 📁 Modular File Structure

```
terraform/
├── main.tf                    # Module calls and provider configuration
├── variables.tf              # All configurable parameters as variables
├── outputs.tf                # All resource outputs from modules
├── terraform.tfvars.example  # Example configuration values
├── README.md                 # This documentation
└── modules/                  # Reusable modules for each service
    ├── resource_group/       # Resource Group module
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── networking/           # Virtual Network and Subnets module
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── monitoring/           # Log Analytics and Application Insights module
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── acr/                  # Azure Container Registry module
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── aks/                  # Azure Kubernetes Service module
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── key_vault/            # Azure Key Vault module
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── sql_database/         # SQL Server and Database module
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── cosmos_db/            # Cosmos DB module
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── application_gateway/  # Application Gateway module
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## 🧩 Module Architecture

Each module is designed to be:
- **Self-contained**: Complete functionality for a specific Azure service
- **Reusable**: Can be used in different environments or projects
- **Configurable**: All parameters exposed as variables
- **Observable**: All resource outputs available for external use

### Module Dependencies
```
resource_group (base)
├── networking (requires: resource_group)
├── monitoring (requires: resource_group)
├── acr (requires: resource_group)
├── sql_database (requires: resource_group)
├── cosmos_db (requires: resource_group)
├── aks (requires: resource_group, networking, monitoring, acr)
├── key_vault (requires: resource_group, aks)
└── application_gateway (requires: resource_group, networking)
```
## 🔧 Modular Architecture Benefits

This configuration is designed with **reusable, modular components**:

- **Service-specific modules**: Each Azure service has its own dedicated module
- **Clear dependencies**: Explicit module dependencies for proper resource ordering
- **Configurable parameters**: All module inputs are exposed as variables
- **Comprehensive outputs**: All resource identifiers and connection strings available
- **Maintainable structure**: Standard Terraform module pattern for each service

### Benefits of This Modular Structure
- **Reusability**: Individual modules can be used in other projects
- **Maintainability**: Easy to update, test, and modify individual services
- **Scalability**: Add new services by creating additional modules
- **Flexibility**: Mix and match modules based on requirements
- **Separation of Concerns**: Each module handles a specific responsibility

## Prerequisites

1. **Azure CLI** installed and configured
2. **Terraform** v1.0+ installed
3. **Azure subscription** with appropriate permissions
4. **Service Principal** for Terraform authentication

## Setup Instructions

### 1. Azure Authentication

Create a service principal for Terraform:

```bash
# Login to Azure
az login

# Create service principal
az ad sp create-for-rbac --name "terraform-copilotx" --role="Contributor" --scopes="/subscriptions/YOUR_SUBSCRIPTION_ID"
```

### 2. Backend Storage

Create Azure Storage Account for Terraform state:

```bash
# Create resource group for Terraform state
az group create --name rg-terraform-state --location "East US"

# Create storage account
az storage account create \
  --name tfstatestorage$(date +%s) \
  --resource-group rg-terraform-state \
  --location "East US" \
  --sku Standard_LRS

# Create storage container
az storage container create \
  --name tfstate \
  --account-name YOUR_STORAGE_ACCOUNT_NAME
```

### 3. Configuration

1. Copy the example variables file:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Edit `terraform.tfvars` with your specific values:
   - Update resource names to ensure uniqueness
   - Set appropriate Azure region
   - Configure database passwords securely

### 4. Deployment

```bash
# Initialize Terraform
terraform init

# Plan the deployment
terraform plan

# Apply the configuration
terraform apply
```

## Using as a Module

This self-contained configuration can also be used as a module in other Terraform configurations:

```hcl
module "azure_infrastructure" {
  source = "./path/to/this/terraform/directory"

  # Required variables
  sql_admin_password = var.sql_admin_password

  # Optional variables
  environment         = "production"
  location           = "West US 2"
  resource_group_name = "rg-copilotx-prod"
  
  # Additional customization...
}
```

## Configuration Variables

All configurable parameters are exposed as variables. See `variables.tf` for the complete list with descriptions and default values. Key variables include:

- `environment` - Environment name (dev/staging/prod)
- `location` - Azure region for resources
- `resource_group_name` - Name of the resource group
- `sql_admin_password` - Required: Administrator password for SQL Server
- `cluster_name` - Name of the AKS cluster
- `enable_auto_scaling` - Enable auto scaling for AKS nodes
- Network configuration variables for VNet and subnets

## Resource Outputs

All created resource identifiers are exposed as outputs. See `outputs.tf` for the complete list. Key outputs include:

- Resource group information
- AKS cluster details and authentication
- Container registry login details
- Key Vault URI and name
- Database connection information
- Virtual network and subnet IDs
- Monitoring workspace details

## GitHub Actions Integration

The infrastructure can be deployed automatically using GitHub Actions workflows:

### Required Secrets

Configure these secrets in your GitHub repository:

```
# Azure Authentication
AZURE_CLIENT_ID=your-service-principal-client-id
AZURE_CLIENT_SECRET=your-service-principal-client-secret
AZURE_SUBSCRIPTION_ID=your-azure-subscription-id
AZURE_TENANT_ID=your-azure-tenant-id

# Terraform Backend
TF_STATE_RESOURCE_GROUP=rg-terraform-state
TF_STATE_STORAGE_ACCOUNT=your-storage-account-name
TF_STATE_CONTAINER_NAME=tfstate

# Database Configuration
SQL_ADMIN_PASSWORD=your-secure-sql-password
```

### Workflows

1. **`terraform-deploy.yml`** - Deploys infrastructure changes
2. **`container-build.yml`** - Builds and pushes container images
3. **`app-deploy.yml`** - Deploys applications to AKS

## Security Considerations

- **Service Principal** has minimal required permissions
- **Key Vault** stores sensitive configuration securely
- **Network Security Groups** restrict traffic flow
- **RBAC** controls access to AKS cluster
- **Sensitive outputs** are properly marked and protected

## Cost Optimization

- Use **Reserved Instances** for predictable workloads
- Enable **Azure Advisor** recommendations
- Configure **auto-shutdown** for development environments
- Monitor costs with **Azure Cost Management**

## Next Steps

After infrastructure deployment:

1. Configure DNS for ingress endpoints
2. Set up SSL certificates for HTTPS
3. Configure backup strategies for databases
4. Implement disaster recovery procedures
5. Set up monitoring alerts and notifications