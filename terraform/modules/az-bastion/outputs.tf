output "id" {
  description = "The ID of the Bastion Host"
  value       = (var.enabled == true ? azurerm_bastion_host.bastion[0].id : null)
}

output "dns_name" {
  description = "The FQDN for the Bastion Host"
  value       = (var.enabled == true ? azurerm_bastion_host.bastion[0].dns_name : null)
}


output "public_ip" {
  description = "The public ip for the Bastion Host"
  value       = (var.enabled == true ? azurerm_public_ip.bastion[0].ip_address : null)
}
