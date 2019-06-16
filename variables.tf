# Global
variable "location" {
  type = "string"
}

# Main Resource Group
variable "main_resource_group_name" {
  type = "string"
}

# Main Virtual Network
variable "main_virtual_network_address_space" {
  type = "string"
}

variable "main_virtual_network_subnet_prefixes" {
  type = "list"
}

variable "main_virtual_network_subnet_names" {
  type = "list"
}
