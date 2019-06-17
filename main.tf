# Use Azure Resource Manager as provider
provider "azurerm" {
  version = "=1.30.1"
}

# Create resource group
resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-resources"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"
}

resource "azurerm_subnet" "main" {
  name                 = "${var.prefix}-subnet"
  resource_group_name  = "${azurerm_resource_group.main.name}"
  virtual_network_name = "${azurerm_virtual_network.main.name}"
  address_prefix       = "10.0.0.0/24"
}

resource "azurerm_public_ip" "main" {
  name                = "${var.prefix}-public-ip"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-nic"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"

  ip_configuration {
    name                          = "mainconfiguration1"
    subnet_id                     = "${azurerm_subnet.main.id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${azurerm_public_ip.main.id}"
  }
}

resource "azurerm_virtual_machine" "main" {
  name                             = "${var.prefix}-vm"
  location                         = "${azurerm_resource_group.main.location}"
  resource_group_name              = "${azurerm_resource_group.main.name}"
  network_interface_ids            = ["${azurerm_network_interface.main.id}"]
  vm_size                          = "Standard_B1s"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys = {
      key_data = "${file("~/.ssh/id_rsa.pub")}"
      path     = "/home/testadmin/.ssh/authorized_keys"
    }
  }

  provisioner "remote-exec" {
    script = "./script.sh"

    connection {
      type = "ssh"
      user = "testadmin"
    }
  }
}
