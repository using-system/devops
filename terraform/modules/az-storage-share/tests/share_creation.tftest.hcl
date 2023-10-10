provider "azurerm" {
  features {
  }
}

run "setup" {
  module {
    source = "./tests/setup"
  }
}

run "plan" {

  command = plan

  variables {
    name                        = "system-az-storage-share"
    storage_account_name        = run.setup.storage_account_name
    quota                       = 10
  }


  assert {
    condition      = azurerm_storage_share.storage.storage_account_name == var.storage_account_name
    error_message  = "share storage_account_name must be set"
  }

  assert {
    condition      = azurerm_storage_share.storage.quota == var.quota
    error_message  = "share quota must be set"
  }
}


run "apply" {

    command = apply

    variables {
        name                        = "system-az-storage-share"
        storage_account_name        = run.setup.storage_account_name
        quota                       = 10
    }

    assert {
        condition       = output.id != "" || output.id == null
        error_message  = "output id is empty"
    }

    assert {
        condition       = output.name == var.name
        error_message  = "output name must be set"
    }

    assert {
        condition       = output.url != "" || output.url == null
        error_message  = "output url is empty"
    }
}