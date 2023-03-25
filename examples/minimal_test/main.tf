variable "api_token" {}

module "init" {
  # This is an example only; if you're adding this block to a live configuration,
  # make sure to use the latest release of the init module, found here:
  # https://github.com/entur/terraform-aiven-kafka-connect-init/releases
  source       = "github.com/entur/terraform-aiven-kafka-connect-init//modules/init?ref=v1.1.3"
  access_token = var.api_token
  project_name = "my-aiven-project"
  service_name = "my-aiven-kafka-connect-service-name"
}

module "bigquery-sink" {
  # This is for local reference only; if you're using this module as a published
  # module from GitHub, the 'source' parameter must refer to it's public location.
  # See README.md for instructions.
  # List of elasticsearch-sink module releases can be found here:
  # https://github.com/entur/terraform-aiven-kafka-connect-bigquery-sink/releases
  #  source                      = "github.com/entur/terraform-aiven-kafka-connect-bigquery-sink//modules/bigquery-sink?ref=vVERSION"
  source                = "../../modules/bigquery-sink"
  init                  = module.init
  connector_name        = "my-connector-name"
  bigquery_project_name = "my-bigquery-project-name"
  bigquery_dataset_name = "my-bigquery-dataset-name"
  service_account_id    = "my-service-account-id@my-project.iam.gserviceaccount.com"
  kafka_username        = "my-kafka-user-name"
  kafka_topics          = ["my-topic-1", "my-topic-2"]
  additional_configuration = {
    "any.other.config.parameter" : "any-other-config-parameter-value"
  }
}