resource "azurerm_storage_account" "storage" {
  name                = "azureteststorage"
  resource_group_name = var.resource_group_name
  location            = var.location

  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  enable_https_traffic_only     = var.enable_https_traffic_only
  min_tls_version               = var.min_tls_version
  shared_access_key_enabled     = var.shared_access_key_enabled
  public_network_access_enabled = var.public_network_access_enabled

  network_rules {
    default_action = var.network_rules_default_action
    bypass         = var.network_rules_bypass
  }

  tags = var.tags
}
