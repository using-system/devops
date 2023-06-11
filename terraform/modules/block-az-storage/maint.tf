resource "azurerm_storage_account" "storage" {
  name                = "azureteststorage"
  resource_group_name = var.resource_group_name
  location            = var.location

  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  enable_https_traffic_only       = var.enable_https_traffic_only
  min_tls_version                 = var.min_tls_version
  shared_access_key_enabled       = var.shared_access_key_enabled
  public_network_access_enabled   = var.public_network_access_enabled
  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public

  network_rules {
    default_action = var.network_rules_default_action
    bypass         = var.network_rules_bypass
  }

  queue_properties {
    logging {
      version = "1.0"
      delete  = true
      read    = true
      write   = true

    }
  }

  blob_properties {
    delete_retention_policy {
      days = var.blob_delete_retention_days
    }
  }

  tags = var.tags
}

resource "azurerm_storage_account_customer_managed_key" "storage" {
  storage_account_id = azurerm_storage_account.storage.id
  key_vault_id       = var.kv_id_cust_managed_key
  key_name           = var.kv_key_id_cust_managed_key
}
