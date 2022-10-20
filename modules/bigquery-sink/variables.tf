variable "init" {
  description = "Entur init module output. https://github.com/entur/terraform-aiven-kafka-connect-init"
  type = object({
    aiven = object({
      project      = string
      service      = string
      access_token = string
    })
    schema_registry = object({
      url      = string
      userinfo = string
    })
    default_configuration = map(string)
  })
}

variable "connector_name" {
  type        = string
  description = "Unique name for this connector in the connect cluster"
}

variable "connector_class" {
  type        = string
  description = "Name or alias of the class for this connector"
  default     = "com.wepay.kafka.connect.bigquery.BigQuerySinkConnector"
}

variable "kafka_topics" {
  type        = list(string)
  description = "List of kafka topic names to sink data from"
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

variable "additional_configuration" {
  type        = map(string)
  default     = {}
  description = "Add additional configuration options as a map"
}
