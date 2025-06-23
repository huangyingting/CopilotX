# Azure Infrastructure Terraform Configuration

This Terraform configuration deploys a complete Azure infrastructure stack for the CopilotX project using a **reusable module structure**. The configuration includes AKS cluster, databases, monitoring, and networking components based on the provided architecture diagram.

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

## 📁 File Structure

```
terraform/
├── main.tf                    # Root configuration using the module
├── variables.tf              # Root variable definitions
├── outputs.tf                # Root output definitions
├── terraform.tfvars.example  # Example variable values
├── README.md                 # This file
└── modules/
    └── azure-infrastructure/
        ├── main.tf           # Module infrastructure resources
        ├── variables.tf      # Module variable definitions
        ├── outputs.tf        # Module output definitions
        └── README.md         # Module documentation
```

## 🔧 Module Structure

This configuration uses a **reusable Terraform module** structure:

- **Root Configuration** (`terraform/`): Contains provider configurations, backend setup, and calls the azure-infrastructure module
- **Module** (`modules/azure-infrastructure/`): Contains the self-contained, reusable infrastructure code

### Benefits of This Structure
- **Reusability**: The module can be used in different environments or projects
- **Maintainability**: Clear separation between module logic and configuration
- **Testability**: Module can be tested independently
- **Composability**: Multiple modules can be combined easily

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
# Initialize Terraform with backend
terraform init \
  -backend-config="resource_group_name=rg-terraform-state" \
  -backend-config="storage_account_name=YOUR_STORAGE_ACCOUNT_NAME" \
  -backend-config="container_name=tfstate" \
  -backend-config="key=terraform.tfstate"

# Plan the deployment
terraform plan

# Apply the configuration
terraform apply
```

## Using the Module

The root configuration in this directory uses the azure-infrastructure module. You can also use the module directly in other configurations:

```hcl
module "azure_infrastructure" {
  source = "./modules/azure-infrastructure"

  # Required variables
  sql_admin_password = var.sql_admin_password

  # Optional variables
  environment         = "production"
  location           = "West US 2"
  resource_group_name = "rg-copilotx-prod"
  
  # Additional customization...
}
```

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

## Module Documentation

For detailed information about the azure-infrastructure module, including all variables and outputs, see:
- [Module README](./modules/azure-infrastructure/README.md)

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