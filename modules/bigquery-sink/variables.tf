variable "aiven_api_token" {
  type        = string
  description = "Aiven API token to be provided by environment variable TF_VAR_api_token"
}

variable "aiven_project_name" {
  type        = string
  description = "Aiven project name"
}

variable "kafka_service_name" {
  type        = string
  description = "Aiven Kafka service name running Kafka Connect"
}

variable "kafka_admin_username" {
  type        = string
  description = "Kafka admin user name for Schema Registry"
  default     = "avnadmin"
}

variable "bigquery_project_name" {
  type        = string
  description = "BigQuery project id"
}

variable "bigquery_dataset_name" {
  type        = string
  description = "BigQuery dataset to sink data to"
}

variable "bigquery_service_account_id" {
  type        = string
  description = "Service account id with google credentials in BigQuery project"
}

variable "kafka_topics" {
  type        = list(string)
  description = "List of kafka topic names to sink data from"
}

variable "connector_name" {
  type        = string
  description = "Unique name for this connector"
}

variable "sanitize_topics" {
  type        = bool
  description = "Designates whether to automatically sanitize topic names before using them as table names. If not enabled, topic names are used as table names"
  default     = true
}

variable "auto_create_tables" {
  type        = bool
  description = "Automatically create BigQuery tables if they don’t already exist"
  default     = true
}

variable "all_bigquery_fields_nullable" {
  type        = bool
  description = "If true, no fields in any produced BigQuery schema are REQUIRED. All non-nullable Avro fields are translated as NULLABLE (or REPEATED, if arrays)"
  default     = true
}

variable "allow_schema_unionization" {
  type        = bool
  description = "If true, the existing table schema (if one is present) will be unionized with new record schemas during schema updates. If false, the record of the last schema in a batch will be used for any necessary table creation and schema update attempts"
  default     = true
}

variable "allow_new_bigquery_fields" {
  type        = bool
  description = "If true, new fields can be added to BigQuery tables during subsequent schema updates"
  default     = true
}

variable "allow_bigquery_required_field_relaxation" {
  type        = bool
  description = "If true, fields in BigQuery Schema can be changed from REQUIRED to NULLABLE"
  default     = true
}

variable "tasks_max" {
  type        = number
  description = "The maximum number of tasks that should be created for this connector. The connector may create fewer tasks if it cannot achieve this level of parallelism"
  default     = 1
}

variable "bigquery_retry_count" {
  type        = number
  description = "The number of retry attempts made for a BigQuery request that fails with a backend error or a quota exceeded error"
  default     = 1
}

variable "key_source_type" {
  type        = string
  description = "Determines whether the keyfile configuration is the path to the credentials JSON file or to the JSON itself. Available values are FILE, JSON & APPLICATION_DEFAULT"
  default     = "JSON"
}

variable "key_converter" {
  type        = string
  description = "Converter class for key Connect data. This controls the format of the data that will be written to Kafka for source connectors or read from Kafka for sink connectors. Popular formats include Avro and JSON"
  default     = "org.apache.kafka.connect.storage.StringConverter"
}

variable "value_converter" {
  type        = string
  description = "Converter class for value Connect data. This controls the format of the data that will be written to Kafka for source connectors or read from Kafka for sink connectors. Popular formats include Avro and JSON"
  default     = "io.confluent.connect.avro.AvroConverter"
}

variable "additional_configuration" {
  type        = map(string)
  default     = {}
  description = "Add additional configuration options as a map"
}
