data "azuread_user" "aad_group_members" {
  for_each            = toset(var.members)
  user_principal_name = each.key
}


resource "azuread_group_member" "aad_group_members" {
  for_each         = toset(var.members)
  group_object_id  = var.group_object_id
  member_object_id = data.azuread_user.aad_group_members[each.key].id
}
