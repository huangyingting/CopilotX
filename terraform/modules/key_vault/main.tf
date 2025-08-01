# Key Vault Module
# Creates Azure Key Vault for secrets management

resource "azurerm_key_vault" "main" {
  name                       = "${var.key_vault_name}-${var.environment}"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = var.tenant_id
  sku_name                   = var.sku_name
  soft_delete_retention_days = var.soft_delete_retention_days
  purge_protection_enabled   = var.purge_protection_enabled

  # Access policy for current user/service principal
  access_policy {
    tenant_id = var.tenant_id
    object_id = var.current_user_object_id

    key_permissions = var.key_permissions

    secret_permissions = var.secret_permissions

    certificate_permissions = var.certificate_permissions
  }

  # Access policy for AKS if provided
  dynamic "access_policy" {
    for_each = var.aks_principal_id != null ? [1] : []
    content {
      tenant_id = var.tenant_id
      object_id = var.aks_principal_id

      secret_permissions = var.aks_secret_permissions
    }
  }

  tags = merge(var.tags, {
    Name        = "${var.key_vault_name}-${var.environment}"
    Environment = var.environment
  })
}