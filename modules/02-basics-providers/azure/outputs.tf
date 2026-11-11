output "resource_group_name" {
  description = "Created resource group name."
  value       = azurerm_resource_group.lab.name
}

output "resource_group_id" {
  description = "Created resource group resource ID."
  value       = azurerm_resource_group.lab.id
}
