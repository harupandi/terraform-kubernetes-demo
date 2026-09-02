# Needed so we can attach NICs to the subnet where the cluster is deployed.
resource "azurerm_user_assigned_identity" "this" {
  name                = var.uami_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_role_assignment" "this" {
  principal_id         = azurerm_user_assigned_identity.this.principal_id
  scope                = var.subnet_id
  role_definition_name = "Network Contributor"
}

resource "azurerm_kubernetes_cluster" "this" {
  name                = var.cluster_name
  resource_group_name = var.resource_group_name
  location            = var.location

  dns_prefix = var.cluster_name

  oidc_issuer_enabled = true

  workload_identity_enabled = true

  sku_tier = var.sku_tier

  kubernetes_version = var.kubernetes_version

  depends_on = [azurerm_role_assignment.this]

  default_node_pool {
    name    = "default"
    vm_size = "Standard_Dsv6"

    auto_scaling_enabled = true
    min_count            = 1
    max_count            = 3
    node_count           = 2
    vnet_subnet_id       = var.subnet_id
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.this.id]
  }

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    service_cidr        = var.service_cidr
    pod_cidr            = var.pod_cidr
    dns_service_ip      = var.dns_service_ip
  }

  lifecycle {
    ignore_changes = [default_node_pool[0].node_count]
  }

  tags = var.tags
}