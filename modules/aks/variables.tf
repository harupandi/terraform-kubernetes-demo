variable "cluster_name" {
  description = "Cluster Name"
  type        = string
}

variable "uami_name" {
  description = "User Assigned Managed Identity name"
  type        = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "sku_tier" {
  type    = string
  default = "Standard"
}

variable "kubernetes_version" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}