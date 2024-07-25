### https://github.com/oracle-devrel/terraform-oci-arch-fn-app/blob/main/functions.tf
resource "oci_core_subnet" "tool_subnet" {
    display_name   = "tool_subnet"
    cidr_block     = "10.0.0.0/24"
    compartment_id = var.compartment_ocid
    vcn_id         = oci_core_vcn.tool_vcn.id
    dns_label      = "toolsubnet"
}

resource "oci_core_vcn" "tool_vcn" {
    display_name    = "tool_vcn"
    cidr_block      = "10.0.0.0/16"
    compartment_id  = var.compartment_ocid
    dns_label       = "toolvnc"
}

resource "oci_functions_application" "tool_application" {
    display_name   = "tool_functions_application"
    compartment_id = var.compartment_ocid
    subnet_ids     = [oci_core_subnet.tool_subnet.id]
}

resource "oci_functions_function" "tool_function" {
    display_name   = "tool_admin_login_notofier"
    application_id = oci_functions_application.tool_application.id
    image          = var.image
    memory_in_mbs  = "256"
    config = { 
      "REGION" : "${var.region}",
      "OCI_Region" : "${var.region}" ,
      "OCI_PrivateRSAKeyEncoded" : filebase64(var.api_key_private_path) 
      "OCI_TenancyOCID" : "${var.tenancy_ocid}" ,
      "OCI_UserOCID" : oci_identity_user.notification_user.id ,
      "OCI_KeyFingerprint" : oci_identity_api_key.api_key.fingerprint ,
      "DEBUG_MODE" : "False"
    }
}

### https://github.com/oracle-quickstart/oci-digital-assistant-external-services/blob/master/apiGateway.tf
resource "oci_apigateway_gateway" "tool_api_gateway" {
    display_name   = "tool_api_gateway"
    compartment_id = var.compartment_ocid
    endpoint_type  = "PUBLIC" 
    subnet_id      = oci_core_subnet.tool_subnet.id
}

resource "oci_apigateway_deployment" "tool_api_gw_deployment" {
    display_name   = "tool_api_gw_deployment"
    compartment_id = var.compartment_ocid
    gateway_id     = oci_apigateway_gateway.tool_api_gateway.id
    path_prefix    = var.deploy_path_prefix
    specification {
        routes {
            backend {
                connect_timeout_in_seconds = 0
                function_id =  oci_functions_function.tool_function.id
                type = "ORACLE_FUNCTIONS_BACKEND"
            }
            methods = [ "GET", "POST" ]
            path = var.route_path
        }
    }
}
