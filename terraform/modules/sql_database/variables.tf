# SQL Database Module Variables

variable "sql_server_name" {
  description = "Name of the SQL Server"
  type        = string
}

variable "sql_database_name" {
  description = "Name of the SQL Database"
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

variable "sql_server_version" {
  description = "Version of the SQL Server"
  type        = string
  default     = "12.0"
}

variable "sql_admin_username" {
  description = "Administrator username for the SQL Server"
  type        = string
}

variable "sql_admin_password" {
  description = "Administrator password for the SQL Server"
  type        = string
  sensitive   = true
}

variable "sql_database_sku" {
  description = "SKU for the SQL Database"
  type        = string
  default     = "Basic"
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}