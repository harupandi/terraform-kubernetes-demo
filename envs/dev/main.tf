resource "azurerm_resource_group" "this" {
  name     = "${local.name_prefix}-rg"
  location = var.location

  tags = local.tags
}

module "network" {
  source              = "../../modules/network"
  name                = "${local.name_prefix}-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = var.address_space
  subnets             = local.subnets
  tags                = local.tags
}

module "aks" {
  source = "../../modules/aks"

  cluster_name        = "${local.name_prefix}-aks"
  uami_name           = "${local.name_prefix}-aks-identity"
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  subnet_id           = module.network.subnet_ids["k8s-cluster"]
  sku_tier            = "Standard"
  kubernetes_version  = var.kubernetes_version
  tags                = local.tags
}