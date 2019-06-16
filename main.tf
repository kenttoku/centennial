# Use Azure Resource Manager as provider
provider "azurerm" {
  version = "=1.30.1"
}

# Create resource group
resource "azurerm_resource_group" "main" {
  name     = "${var.main_resource_group_name}"
  location = "${var.location}"
}

module "network" "main" {
  source              = "Azure/network/azurerm"
  resource_group_name = "${azurerm_resource_group.main.name}"
  location            = "${var.location}"
  address_space       = "${var.main_virtual_network_address_space}"
  subnet_prefixes     = "${var.main_virtual_network_subnet_prefixes}"
  subnet_names        = "${var.main_virtual_network_subnet_names}"
}
