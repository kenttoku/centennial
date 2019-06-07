provider "azurerm" {
  version = "=1.30.1"
}

resource "azurerm_resource_group" "rg" {
  name     = "myTFResourceGroup"
  location = "eastus"

  tags {
    environment = "TF sandbox"
  }
}
