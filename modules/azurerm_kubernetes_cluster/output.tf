output "aks_names" {
  description = "List of AKS cluster names"
  value       = [for aks in azurerm_kubernetes_cluster.aks : aks.name]
}

output "aks_kubeconfigs" {
  description = "Kubeconfig for each AKS cluster"
  value = {
    for k, v in azurerm_kubernetes_cluster.aks :
    k => v.kube_config_raw
  }
  sensitive = true
}

output "aks_identities" {
  description = "System-assigned identities for AKS clusters"
  value = {
    for k, v in azurerm_kubernetes_cluster.aks :
    k => v.identity[0].principal_id
  }
}
