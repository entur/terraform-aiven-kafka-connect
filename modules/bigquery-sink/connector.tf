data "aiven_project" "entur_kafka" {
  project = var.aiven_project_name
}

data "aiven_kafka_user" "kafka_admin" {
  project      = data.aiven_project.entur_kafka.project
  service_name = var.kafka_service_name
  username     = var.kafka_admin_username
}

data "aiven_service_component" "schema-registry" {
  project      = data.aiven_project.entur_kafka.project
  service_name = var.kafka_service_name
  component    = "schema_registry"
  route        = "dynamic"
}

data "google_service_account" "bq-sa" {
  account_id = var.bigquery_service_account_id
  project    = var.bigquery_project_name
}

resource "google_service_account_key" "bq-sa-key" {
  service_account_id = data.google_service_account.bq-sa.name
}

locals {
  schema_registry_url      = "https://${data.aiven_service_component.schema-registry.host}:23714"
  schema_registry_userinfo = "${data.aiven_kafka_user.kafka_admin.username}:${data.aiven_kafka_user.kafka_admin.password}"
  bq_sa_key                = base64decode(google_service_account_key.bq-sa-key.private_key)
}

resource "aiven_kafka_connector" "bigquery-sink-connector" {
  connector_name = var.connector_name
  project        = data.aiven_project.entur_kafka.project
  service_name   = var.kafka_service_name
  config         = {
    "name" : var.connector_name,
    "connector.class" : "com.wepay.kafka.connect.bigquery.BigQuerySinkConnector",
    "sanitizeTopics" : var.sanitize_topics,
    "autoCreateTables" : var.auto_create_tables,
    "allBQFieldsNullable" : var.all_bigquery_fields_nullable,
    "allowSchemaUnionization" : var.allow_schema_unionization,
    "allowNewBigQueryFields" : var.allow_new_bigquery_fields,
    "allowBigQueryRequiredFieldRelaxation" : var.allow_bigquery_required_field_relaxation,
    "tasks.max" : var.tasks_max,
    "bigQueryRetry" : var.bigquery_retry_count,
    "topics" : join(",", var.kafka_topics),
    "project" : var.bigquery_project_name,
    "defaultDataset" : var.bigquery_dataset_name,
    "keySource" : var.key_source_type,
    "keyfile" : local.bq_sa_key,
    "key.converter" : var.key_converter,
    "key.converter.schema.registry.url" : local.schema_registry_url,
    "key.converter.basic.auth.credentials.source" : "USER_INFO",
    "key.converter.schema.registry.basic.auth.user.info" : local.schema_registry_userinfo,
    "value.converter" : var.value_converter,
    "value.converter.schema.registry.url" : local.schema_registry_url,
    "value.converter.basic.auth.credentials.source" : "USER_INFO",
    "value.converter.schema.registry.basic.auth.user.info" : local.schema_registry_userinfo,
    "transforms" : "regexTransformation",
    "transforms.regexTransformation.regex" : "(.*)",
    "transforms.regexTransformation.replacement" : "$1",
    "transforms.regexTransformation.type" : "org.apache.kafka.connect.transforms.RegexRouter"
  }
}
