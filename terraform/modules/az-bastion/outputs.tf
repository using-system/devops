output "id" {
  value = (var.enabled == true ? azurerm_bastion_host.bastion[0].id : null)
}

output "dns_name" {
  value = (var.enabled == true ? azurerm_bastion_host.bastion[0].dns_name : null)
}


output "public_ip" {
  value = (var.enabled == true ? azurerm_public_ip.bastion[0].ip_address : null)
}
