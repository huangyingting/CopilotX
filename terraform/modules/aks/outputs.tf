# AKS Module Outputs

output "aks_id" {
  description = "ID of the AKS cluster"
  value       = azurerm_kubernetes_cluster.main.id
}

output "aks_name" {
  description = "Name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.main.name
}

output "aks_fqdn" {
  description = "FQDN of the AKS cluster"
  value       = azurerm_kubernetes_cluster.main.fqdn
}

output "aks_node_resource_group" {
  description = "Node resource group name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.main.node_resource_group
}

output "kube_config" {
  description = "Kube config for the AKS cluster"
  value       = azurerm_kubernetes_cluster.main.kube_config_raw
  sensitive   = true
}

output "client_certificate" {
  description = "Client certificate for the AKS cluster"
  value       = azurerm_kubernetes_cluster.main.kube_config.0.client_certificate
  sensitive   = true
}

output "client_key" {
  description = "Client key for the AKS cluster"
  value       = azurerm_kubernetes_cluster.main.kube_config.0.client_key
  sensitive   = true
}

output "cluster_ca_certificate" {
  description = "Cluster CA certificate for the AKS cluster"
  value       = azurerm_kubernetes_cluster.main.kube_config.0.cluster_ca_certificate
  sensitive   = true
}

output "host" {
  description = "Host for the AKS cluster"
  value       = azurerm_kubernetes_cluster.main.kube_config.0.host
}

output "aks_identity_principal_id" {
  description = "Principal ID of the AKS cluster identity"
  value       = azurerm_kubernetes_cluster.main.identity[0].principal_id
}

output "kubelet_identity_object_id" {
  description = "Object ID of the kubelet identity"
  value       = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
}