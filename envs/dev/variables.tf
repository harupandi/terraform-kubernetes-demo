variable "project_name" {
  type    = string
  default = "terraform-demo"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "location" {
  type    = string
  default = "South Central US"
}

variable "kubernetes_version" {
  type    = string
  default = "1.35"
}

variable "pod_cidr" {
  type = string
}

variable "service_cidr" {
  type = string
}

variable "dns_service_ip" {
  type = string
}