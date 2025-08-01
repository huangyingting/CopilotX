# Application Gateway Module Variables

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

variable "app_gateway_subnet_id" {
  description = "ID of the subnet for Application Gateway"
  type        = string
}

variable "sku_name" {
  description = "SKU name for the Application Gateway"
  type        = string
  default     = "Standard_v2"
}

variable "sku_tier" {
  description = "SKU tier for the Application Gateway"
  type        = string
  default     = "Standard_v2"
}

variable "sku_capacity" {
  description = "SKU capacity for the Application Gateway"
  type        = number
  default     = 2
}

variable "frontend_port_name" {
  description = "Name of the frontend port"
  type        = string
  default     = "frontend-port"
}

variable "frontend_port" {
  description = "Frontend port number"
  type        = number
  default     = 80
}

variable "frontend_ip_configuration_name" {
  description = "Name of the frontend IP configuration"
  type        = string
  default     = "frontend-ip-configuration"
}

variable "backend_address_pool_name" {
  description = "Name of the backend address pool"
  type        = string
  default     = "backend-address-pool"
}

variable "backend_http_settings_name" {
  description = "Name of the backend HTTP settings"
  type        = string
  default     = "backend-http-settings"
}

variable "cookie_based_affinity" {
  description = "Cookie based affinity setting"
  type        = string
  default     = "Disabled"
}

variable "backend_port" {
  description = "Backend port number"
  type        = number
  default     = 80
}

variable "backend_protocol" {
  description = "Backend protocol"
  type        = string
  default     = "Http"
}

variable "request_timeout" {
  description = "Request timeout in seconds"
  type        = number
  default     = 60
}

variable "http_listener_name" {
  description = "Name of the HTTP listener"
  type        = string
  default     = "http-listener"
}

variable "listener_protocol" {
  description = "Protocol for the HTTP listener"
  type        = string
  default     = "Http"
}

variable "request_routing_rule_name" {
  description = "Name of the request routing rule"
  type        = string
  default     = "request-routing-rule"
}

variable "rule_type" {
  description = "Type of the routing rule"
  type        = string
  default     = "Basic"
}

variable "routing_rule_priority" {
  description = "Priority of the routing rule"
  type        = number
  default     = 1
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}