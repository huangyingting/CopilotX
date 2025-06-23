# Application Gateway Module
# Creates Public IP and Application Gateway for load balancing

# Public IP for Application Gateway
resource "azurerm_public_ip" "app_gateway" {
  name                = "pip-appgw-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = merge(var.tags, {
    Name        = "pip-appgw-${var.environment}"
    Environment = var.environment
  })
}

# Application Gateway
resource "azurerm_application_gateway" "main" {
  name                = "appgw-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location

  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    capacity = var.sku_capacity
  }

  gateway_ip_configuration {
    name      = "gateway-ip-configuration"
    subnet_id = var.app_gateway_subnet_id
  }

  frontend_port {
    name = var.frontend_port_name
    port = var.frontend_port
  }

  frontend_ip_configuration {
    name                 = var.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.app_gateway.id
  }

  backend_address_pool {
    name = var.backend_address_pool_name
  }

  backend_http_settings {
    name                  = var.backend_http_settings_name
    cookie_based_affinity = var.cookie_based_affinity
    port                  = var.backend_port
    protocol              = var.backend_protocol
    request_timeout       = var.request_timeout
  }

  http_listener {
    name                           = var.http_listener_name
    frontend_ip_configuration_name = var.frontend_ip_configuration_name
    frontend_port_name             = var.frontend_port_name
    protocol                       = var.listener_protocol
  }

  request_routing_rule {
    name                       = var.request_routing_rule_name
    rule_type                  = var.rule_type
    http_listener_name         = var.http_listener_name
    backend_address_pool_name  = var.backend_address_pool_name
    backend_http_settings_name = var.backend_http_settings_name
    priority                   = var.routing_rule_priority
  }

  tags = merge(var.tags, {
    Name        = "appgw-${var.environment}"
    Environment = var.environment
  })
}