variable "api_token" {}
module "bigquery-sink" {
  # This is for local reference only; if you're using this module as a published
  # module from GitHub, the 'source' parameter must refer to it's public location.
  #  source                      = "github.com/entur/terraform-aiven-kafka-connect/modules/bigquery-sink?ref=vVERSION"
  source                      = "../../modules/bigquery-sink"
  aiven_api_token             = var.api_token
  aiven_project_name          = "ent-sbx"
  kafka_service_name          = "entur-kafka-test-int"
  bigquery_project_name       = "entur-data-raw"
  bigquery_dataset_name       = "aiven_bq_sink_connector_module_test"
  bigquery_service_account_id = "kcbqs-api"
  kafka_topics                = ["test-topic-staging"]
  connector_name              = "aiven-bq-sink-connector-module-test"
}
