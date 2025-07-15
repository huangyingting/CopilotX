# Cosmos DB Module Variables

variable "cosmosdb_account_name" {
  description = "Name of the Cosmos DB account"
  type        = string
}

variable "cosmosdb_database_name" {
  description = "Name of the Cosmos DB SQL database"
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

variable "offer_type" {
  description = "Offer type for the Cosmos DB account"
  type        = string
  default     = "Standard"
}

variable "cosmos_kind" {
  description = "Kind of Cosmos DB account"
  type        = string
  default     = "GlobalDocumentDB"
}

variable "consistency_level" {
  description = "Consistency level for the Cosmos DB account"
  type        = string
  default     = "Session"
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}