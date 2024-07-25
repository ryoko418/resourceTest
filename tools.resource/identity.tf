resource "oci_identity_group" "notification_group" {
    compartment_id = var.tenancy_ocid
    description = "notification_tool_fn_group"
    name = var.notification_group_name
}

resource "oci_identity_dynamic_group" "notification_dynamic_group" {
    compartment_id = var.tenancy_ocid
    description = "notification_tool_gw_dynamic_group" 
    #matching_rule = var.dynamic_group_gw_matching_rule
    matching_rule = "Any {ALL {resource.type = 'ApiGateway', resource.compartment.id = '${var.compartment_ocid}'}}"
    name = var.dynamic_group_name
}

resource "oci_identity_user" "notification_user" {
    compartment_id = var.tenancy_ocid
    description = "notification_tool_user"
    name = var.tool_user_name

    #Optional
    email = var.tool_user_email
}

resource "oci_identity_user_capabilities_management" "test_user_capabilities_management" {
    #Required
    user_id = oci_identity_user.notification_user.id

    #Optional 
    can_use_api_keys             = "true"
}

resource "oci_identity_api_key" "api_key" {
    #Required
    key_value = file("${var.api_key_pub_path}") 
    user_id = oci_identity_user.notification_user.id
}

resource "oci_identity_user_group_membership" "user_group_membership" {
    #Required
    compartment_id = var.tenancy_ocid

    #Optional
    group_id = oci_identity_group.notification_group.id
    user_id = oci_identity_user.notification_user.id
}
