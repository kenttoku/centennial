# Use Azure Resource Manager as provider
provider "azurerm" {
  version = "=1.30.1"
}

# Create resource group
resource "azurerm_resource_group" "main" {
  name     = "${var.main_resource_group["name"]}"
  location = "${var.location}"
}

module "network" "main" {
  source              = "Azure/network/azurerm"
  resource_group_name = "${azurerm_resource_group.main.name}"
  location            = "${var.location}"
  address_space       = "10.0.0.0/16"
  subnet_prefixes     = ["10.0.0.0/24"]
  subnet_names        = ["subnet1"]
}

