
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
    group_object_id     = run.setup.group_object_id
    members             = [run.setup.member_object_id]
  }

  assert {
    condition       = length(azuread_group_member.aad_group_members) == 1
    error_message  = "azuread_group_member.aad_group_members must contains one element"
  }

  assert {
    condition      = azuread_group_member.aad_group_members[var.members[0]].group_object_id == var.group_object_id
    error_message  = "azuread_group_member group_object_id must be set"
  }

  assert {
    condition      = azuread_group_member.aad_group_members[var.members[0]].member_object_id == var.members[0]
    error_message  = "azuread_group_member member_object_id must be set"
  }

}


run "apply" {

    command = apply

    variables {
        group_object_id     = run.setup.group_object_id
        members             = [run.setup.member_object_id]
    }
}