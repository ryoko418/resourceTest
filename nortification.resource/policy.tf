locals {
  service_connect_hub_audit_log_policy_statements = [
    # define must be the first
    "Define tenancy ${var.tool_tenancy_name} as ${var.tool_tenancy_ocid}",
    "Define group ${var.tool_group_name} as ${var.tool_group_ocid}",
    "Admit group ${var.tool_group_name} of tenancy ${var.tool_tenancy_name} to inspect groups in tenancy",
    "Admit group ${var.tool_group_name} of tenancy ${var.tool_tenancy_name} to inspect users in tenancy",
    "Admit group ${var.tool_group_name} of tenancy ${var.tool_tenancy_name} to inspect group-memberships in tenancy"
  ]
}

resource "oci_identity_policy" "child_policy" {
  compartment_id = var.tenancy_ocid
  name = "GovCloud-Notification-Child-Policy"
  description = "GovCloud Service Connect Hub for Notification ポリシー "
  statements = local.service_connect_hub_audit_log_policy_statements
}
