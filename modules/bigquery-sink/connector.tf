data "google_service_account" "bq-sa" {
  account_id = var.bigquery_service_account_id
  project    = var.bigquery_project_name
}

resource "google_service_account_key" "bq-sa-key" {
  service_account_id = data.google_service_account.bq-sa.name
}

locals {
  bq_sa_key = base64decode(google_service_account_key.bq-sa-key.private_key)
  standard_configuration = merge(
    var.init.default_configuration,
    {
      "name" : var.connector_name,
      "connector.class" : var.connector_class,
      "project" : var.bigquery_project_name,
      "defaultDataset" : var.bigquery_dataset_name,
      "topics" : join(",", toset(var.kafka_topics)),
      "sanitizeTopics" : var.sanitize_topics,
      "autoCreateTables" : var.auto_create_tables,
      "allBQFieldsNullable" : var.all_bigquery_fields_nullable,
      "allowSchemaUnionization" : var.allow_schema_unionization,
      "allowNewBigQueryFields" : var.allow_new_bigquery_fields,
      "allowBigQueryRequiredFieldRelaxation" : var.allow_bigquery_required_field_relaxation,
      "bigQueryRetry" : var.bigquery_retry_count,
      "keySource" : var.key_source_type,
      "keyfile" : local.bq_sa_key,
      "transforms" : "regexTransformation",
      "transforms.regexTransformation.regex" : "(.*)",
      "transforms.regexTransformation.replacement" : "$1",
      "transforms.regexTransformation.type" : "org.apache.kafka.connect.transforms.RegexRouter"
    }
  )
}

resource "aiven_kafka_connector" "bigquery-sink-connector" {
  connector_name = var.connector_name
  project        = var.init.aiven.project
  service_name   = var.init.aiven.service
  config         = merge(local.standard_configuration, var.additional_configuration)
}
