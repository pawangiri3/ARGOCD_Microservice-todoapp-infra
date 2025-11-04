output "rg_names" {
  description = "List of all created resource group names"
  value       = [for rg in azurerm_resource_group.rg : rg.name]
}
