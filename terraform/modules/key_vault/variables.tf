# Key Vault Module Variables

variable "key_vault_name" {
  description = "Name of the Key Vault"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}

variable "current_user_object_id" {
  description = "Object ID of the current user or service principal"
  type        = string
}

variable "sku_name" {
  description = "SKU name for the Key Vault"
  type        = string
  default     = "standard"
}

variable "soft_delete_retention_days" {
  description = "Soft delete retention days for the Key Vault"
  type        = number
  default     = 7
}

variable "purge_protection_enabled" {
  description = "Enable purge protection for the Key Vault"
  type        = bool
  default     = false
}

variable "key_permissions" {
  description = "Key permissions for the access policy"
  type        = list(string)
  default = [
    "Create",
    "Get",
    "List",
    "Update",
    "Delete",
    "Purge",
    "Recover"
  ]
}

variable "secret_permissions" {
  description = "Secret permissions for the access policy"
  type        = list(string)
  default = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Purge",
    "Recover"
  ]
}

variable "certificate_permissions" {
  description = "Certificate permissions for the access policy"
  type        = list(string)
  default = [
    "Get",
    "List",
    "Create",
    "Update",
    "Delete",
    "Purge",
    "Recover"
  ]
}

variable "aks_principal_id" {
  description = "Principal ID of the AKS cluster for access policy (optional)"
  type        = string
  default     = null
}

variable "aks_secret_permissions" {
  description = "Secret permissions for AKS access policy"
  type        = list(string)
  default = [
    "Get",
    "List"
  ]
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}