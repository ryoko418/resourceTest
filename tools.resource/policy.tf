resource "oci_identity_policy" "tool_policy" {
  //provider = "oci.acceptor"
  description = "Tools policy"
  compartment_id = var.tenancy_ocid
  for_each = { for u in var.child_tenancy : u.name => u }
  name = "${each.key}"
  statements = ["Define tenancy ${each.key} as ${each.value.ocid}" ,
                "Endorse group ${var.notification_group_name} to manage groups in tenancy ${each.key}",
                "Endorse group ${var.notification_group_name} to manage group-memberships in tenancy ${each.key}",
                "Endorse group ${var.notification_group_name} to manage users in tenancy ${each.key}"
               ]

}

resource "oci_identity_policy" "tool_gw_policy" {
  description = "Tools GW policy"
  compartment_id = var.tenancy_ocid
  name = "notification_tool_gw_policy" 
  statements = ["Allow dynamic-group ${var.dynamic_group_name} to use functions-family in tenancy" ]
}
