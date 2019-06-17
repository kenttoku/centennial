output "main_resource_group_name" {
  value = "${azurerm_resource_group.main.name}"
}

output "vm_ip" {
  value = "${azurerm_public_ip.main.ip_address}"
}
