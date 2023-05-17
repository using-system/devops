resource "azuread_group_member" "aad_group_members" {
  for_each         = toset(var.members)
  group_object_id  = var.group_object_id
  member_object_id = var.members
}
