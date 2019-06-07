# Use Azure Resource Manager as provider
provider "azurerm" {
  version = "=1.30.1"
}

# Create resource group
resource "azurerm_resource_group" "rg" {
  name     = "myTFResourceGroup"
  location = "eastus"

  tags {
    environment = "TF sandbox"
  }
}

# Create virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "myTFVnet"
  address_space       = ["10.0.0.0/16"]
  location            = "eastus"
  resource_group_name = "${azurerm_resource_group.rg.name}"
}

# Create subnet
resource "azurerm_subnet" "subnet" {
  name                 = "myTFSubnet"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefix       = "10.0.1.0/24"
}
