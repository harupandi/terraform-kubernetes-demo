variable "name" {
  description = "Cluster Name"
  type        = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type    = string
  default = "South Central US"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "address_space" {
  type    = list(string)
}

variable "subnets" {
  type = map(object({
    address_prefixes = list(string)
  }))
}