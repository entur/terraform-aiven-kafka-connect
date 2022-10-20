variable "my_aiven_access_token" {}

module "init" {
  # This is an example only; if you're adding this block to a live configuration,
  # make sure to use the latest release of the init module, found here:
  # https://github.com/entur/terraform-aiven-kafka-connect-init/releases
  source       = "github.com/entur/terraform-aiven-kafka-connect-init//modules/init?ref=v1.1.2"
  access_token = var.my_aiven_access_token
  project_name = "my-aiven-project"
  service_name = "my-aiven-kafka-connect-service-name"
}

# ci: x-release-please-start-version

module "bigquery-sink" {
  # This is an example only; if you're adding this block to a live configuration,
  # make sure to use the latest release of the init module, found here:
  # https://github.com/entur/terraform-aiven-kafka-connect-bigquery-sink/releases
  source                      = "github.com/entur/terraform-aiven-kafka-connect-bigquery-sink//modules/bigquery-sink?ref=v0.1.0"
  init                        = module.init
  connector_name              = "my-connector-name"
  bigquery_project_name       = "my-bigquery-project-name"
  bigquery_dataset_name       = "my-bigquery-dataset-name"
  bigquery_service_account_id = "my-service-account-id"
  kafka_topics                = ["my-topic-1", "my-topic-2"]
  additional_configuration = {
    "value.converter.schema.registry.url" : "https://my-aiven-resgistry-service-host-name:my-aiven-resgistry-service-port-number"
  }
}

# ci: x-release-please-end