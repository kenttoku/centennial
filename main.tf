# Use Azure Resource Manager as provider
provider "azurerm" {
  version = "=1.30.1"
}

# Create resource group
resource "azurerm_resource_group" "main" {
  name     = "terraform"
  location = "${var.location}"
}
