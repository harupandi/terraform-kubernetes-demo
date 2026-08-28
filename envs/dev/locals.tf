locals {
  name_prefix = "${var.project_name}-${var.environment}"

  subnets = {
    "k8s-cluster" = {
      address_prefixes = ["10.0.1.0/24"]
    }
  }

  project_name = "terraform-demo"

  address_space = ["10.0.0.0/16"]

  location = "South Central US"

  tags = {
    Project   = var.project_name
    ManagedBy = "Terraform"
  }
}