output "kube_config_raw" {
  value = azurerm_kubernetes_cluster.example.kube_config_raw

  sensitive = true
}