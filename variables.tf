variable "location" {
  type = "string"
}

variable "main_resource_group" {
  type = "map"
}

variable "main_virtual_network_address_space" {
  type    = "string"
  default = "10.0.0.0/16"
}

variable "main_virtual_network_subnet_prefixes" {
  type    = "list"
  default = ["10.0.0.0/24"]
}

variable "main_virtual_network_subnet_names" {
  type    = "list"
  default = ["subnet1"]
}
