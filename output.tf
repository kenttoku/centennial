output "main_resource_group_name" {
  value = "${azurerm_resource_group.main.name}"
}

output "main_vnet_subnets" {
  value = "${module.network.vnet_subnets}"
}
