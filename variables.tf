variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_cidr" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "base_name" {
  type = string
}