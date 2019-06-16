# Use Azure Resource Manager as provider
provider "azurerm" {
  version = "=1.30.1"
}

# Create resource group
resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-resources"
  location = "${var.location}"
}

module "network" {
  source              = "Azure/network/azurerm"
  vnet_name           = "${var.prefix}-vnet"
  resource_group_name = "${azurerm_resource_group.main.name}"
  location            = "${var.location}"
}
