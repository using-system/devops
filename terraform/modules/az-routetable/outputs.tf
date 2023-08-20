output "rt_ids" {
  description = "Map of Route Table names to their respective IDs."
  value       = { for key, rt in azurerm_route_table.network : key => rt.id }
}
