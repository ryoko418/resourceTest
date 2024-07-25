### https://github.com/oracle/terraform-provider-oci/blob/master/examples/service_connector_hub/main.tf

resource "oci_ons_notification_topic" "servicehub_notification_topic" {
    compartment_id = var.compartment_ocid
    name = "NortificationConnectorTopic"
}

resource "oci_ons_subscription" "servicehub_subscription" {
    compartment_id = var.compartment_ocid
    endpoint = var.endpoint
    protocol = "CUSTOM_HTTPS"
    topic_id = oci_ons_notification_topic.servicehub_notification_topic.id
    delivery_policy =  "{\"maxReceiveRatePerSecond\":0,\"backoffRetryPolicy\":{\"initialDelayInFailureRetry\":60000,\"maxRetryDuration\":7200000,\"policyType\":\"EXPONENTIAL\"}}"
}

resource "oci_sch_service_connector" "service_connector" {
  compartment_id = var.compartment_ocid
  description    = "Notifiy administrator login"
  display_name   = "NortificationConnector"

  freeform_tags = {
    "Department" = "Accounting"
  }

  source {
     kind = "logging"

     log_sources {
       compartment_id = var.compartment_ocid
       log_group_id   = "_Audit"
     }
  }
  target {
    kind =  "notifications"
    topic_id = oci_ons_notification_topic.servicehub_notification_topic.id
    batch_rollover_size_in_mbs = 0
    batch_rollover_time_in_ms  = 0
    batch_size_in_kbs          = 6144
    batch_size_in_num          = 0
    batch_time_in_sec          = 60
    enable_formatted_messaging = false
  }
  tasks {
      batch_size_in_kbs = 0
      batch_time_in_sec = 0
      condition =  "(type='com.oraclecloud.identitysignon.interactivelogin') AND (isNull(data.request.action) OR data.request.action!='GET')"
      function_id = ""
      kind = "logRule"
 }

  state = "ACTIVE"
}

