# AKS Module Variables

variable "cluster_name" {
  description = "Name of the AKS cluster"
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

variable "kubernetes_version" {
  description = "Version of Kubernetes to use for the AKS cluster"
  type        = string
  default     = "1.28.3"
}

variable "node_count" {
  description = "Number of nodes in the AKS cluster (used when auto-scaling is disabled)"
  type        = number
  default     = 2
}

variable "node_size" {
  description = "Size of the nodes in the AKS cluster"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "aks_subnet_id" {
  description = "ID of the subnet for AKS cluster"
  type        = string
}

variable "enable_auto_scaling" {
  description = "Enable auto-scaling for the AKS cluster"
  type        = bool
  default     = true
}

variable "min_node_count" {
  description = "Minimum number of nodes for auto-scaling"
  type        = number
  default     = 1
}

variable "max_node_count" {
  description = "Maximum number of nodes for auto-scaling"
  type        = number
  default     = 10
}

variable "log_analytics_workspace_id" {
  description = "ID of the Log Analytics workspace for monitoring"
  type        = string
}

variable "acr_id" {
  description = "ID of the Azure Container Registry for role assignment"
  type        = string
}

variable "azure_policy_enabled" {
  description = "Enable Azure Policy for the AKS cluster"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}