# Azure Infrastructure for CopilotX

This directory contains Terraform configuration files for deploying the CopilotX infrastructure on Azure, based on the architecture diagram that includes:

## Architecture Components

### Core Infrastructure
- **Azure Kubernetes Service (AKS)** - Container orchestration platform
- **Azure Container Registry (ACR)** - Container image storage
- **Azure Load Balancer** - Network load balancing (via Application Gateway)
- **Azure Key Vault** - Secrets and certificate management
- **Virtual Network** - Network isolation and security

### Data Services
- **Azure SQL Database** - Relational database for Service 1
- **Azure Cosmos DB** - NoSQL database for Services 2 & 3

### Monitoring & Logging
- **Azure Monitor** - Infrastructure monitoring
- **Log Analytics Workspace** - Centralized logging
- **Application Insights** - Application performance monitoring

### Kubernetes Components (Deployed via Helm)
- **NGINX Ingress Controller** - HTTP/HTTPS load balancing
- **Backend Services** - Three microservices with auto-scaling
- **Prometheus** - Metrics collection and monitoring
- **Elasticsearch** - Log aggregation and search

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

## File Structure

```
terraform/
├── backend.tf              # Remote state configuration
├── main.tf                 # Main infrastructure resources
├── providers.tf            # Provider configurations
├── variables.tf            # Input variable definitions
├── outputs.tf              # Output value definitions
├── terraform.tfvars.example # Example variable values
└── README.md               # This documentation
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

# Container Registry (populated after deployment)
ACR_LOGIN_SERVER=your-acr-name.azurecr.io
ACR_USERNAME=your-acr-username
ACR_PASSWORD=your-acr-password

# AKS Configuration (populated after deployment)
RESOURCE_GROUP_NAME=your-resource-group-name
AKS_CLUSTER_NAME=your-aks-cluster-name
```

### Workflows

1. **`terraform-deploy.yml`** - Deploys infrastructure changes
2. **`container-build.yml`** - Builds and pushes container images
3. **`app-deploy.yml`** - Deploys applications to AKS

## Security Considerations

- **Service Principal** has minimal required permissions
- **Key Vault** stores sensitive configuration securely
- **Network Security Groups** restrict traffic flow
- **Azure Policy** enforces compliance standards
- **RBAC** controls access to AKS cluster

## Monitoring and Observability

- **Prometheus** collects metrics from applications
- **Grafana** provides visualization dashboards
- **Elasticsearch** centralizes application logs
- **Azure Monitor** tracks infrastructure health
- **Application Insights** monitors application performance

## Scaling Configuration

### Manual Scaling
```bash
# Scale AKS nodes
az aks scale --resource-group myResourceGroup --name myAKSCluster --node-count 5

# Scale application pods
kubectl scale deployment service1 --replicas=5 -n backend
```

### Auto-scaling
- **Cluster Autoscaler** automatically scales AKS nodes
- **Horizontal Pod Autoscaler** scales Service 3 based on CPU/memory
- **Vertical Pod Autoscaler** can be configured for right-sizing

## Troubleshooting

### Common Issues

1. **Resource Name Conflicts**: Ensure globally unique names for ACR and Key Vault
2. **Permission Errors**: Verify service principal has Contributor role
3. **Network Connectivity**: Check NSG rules and subnet configurations
4. **Storage Backend**: Ensure storage account exists and is accessible

### Useful Commands

```bash
# Check Terraform state
terraform state list

# Import existing resource
terraform import azurerm_resource_group.main /subscriptions/SUB_ID/resourceGroups/RG_NAME

# Destroy infrastructure (use with caution)
terraform destroy
```

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