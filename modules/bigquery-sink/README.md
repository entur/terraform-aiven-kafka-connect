# Google's BigQuery sink connector module

Terraform module for deploying Google's BigQuery sink connector on an Aiven managed Kafka service

## Configuration

| Name                                     | Description                                                                 |     Type     |                      Default                       | Required |
|------------------------------------------|-----------------------------------------------------------------------------|:------------:|:--------------------------------------------------:|:--------:|
| api_token                                | Aiven API token to be provided by environment variable `TF_VAR_api_token`   |    string    |                        n/a                         |   yes    |
| connector_name                           | Unique name for this connector                                              |    string    |                        n/a                         |   yes    |
| aiven_project_name                       | Aiven project where KafkaConnect cluster is running                         |    string    |                        n/a                         |   yes    |
| kafka_service_name                       | Aiven (Kafka)service name where KafkaConnect cluster is running             |    string    |                        n/a                         |   yes    |
| kafka_admin_username                     | Kafka admin user name for Schema Registry                                   |    string    |                     "avnadmin"                     |   yes    |
| bigquery_project_name                    | BigQuery project id where data to be sinked                                 |    string    |                        n/a                         |   yes    |
| bigquery_dataset_name                    | BigQuery dataset name where data to be sinked                               |    string    |                        n/a                         |   yes    |
| bigquery_service_account_id              | Service account id with google credentials in `bigquery_project_name`       |    string    |                        n/a                         |   yes    |
| kafka_topics                             | List of kafka topic names to sink data from                                 | list(string) |                        n/a                         |   yes    |
| sanitize_topics                          | Automatically sanitize topic names before using them as table names         |     bool     |                        true                        |    no    |
| auto_create_tables                       | Automatically create BigQuery tables if they don’t already exist            |     bool     |                        true                        |    no    |
| all_bigquery_fields_nullable             | If true, no fields in any produced BigQuery schema are REQUIRED             |     bool     |                        true                        |    no    |
| allow_schema_unionization                | If true, existing table schema will be unionized with new record schemas    |     bool     |                        true                        |    no    |
| allow_new_bigquery_fields                | If true, new fields can be added to BigQuery tables during schema updates   |     bool     |                        true                        |    no    |
| allow_bigquery_required_field_relaxation | If true, fields in BigQuery Schema can be changed from REQUIRED to NULLABLE |     bool     |                        true                        |    no    |
| tasks_max                                | The maximum number of tasks that should be created for this connector       |    number    |                         1                          |    no    |
| bigquery_retry_count                     | Retry attempts made for a failed BigQuery request                           |    number    |                         1                          |    no    |
| key_source_type                          | Key type for Google credentials with access to `bigquery_dataset_name`      |    string    |                       "JSON"                       |    no    |
| key_converter                            | Converter class for key data on a connect record                            |    string    | "org.apache.kafka.connect.storage.StringConverter" |    no    |
| value_converter                          | Converter class for value data on a connect record                          |    string    |     "io.confluent.connect.avro.AvroConverter"      |    no    |

[Example](./../../examples/bigquery-sink/main.tf)
Sample configuration for reference

## Getting started

- Set an environment variable `TF_VAR_api_token` with Aiven authentication token
- Make sure that BigQuery project with name pointed by `bigquery_project_name` exists and has a dataset with name `bigquery_dataset_name` exists.
- Make sure that the service account with id `bigquery_service_account_id` exists in project `bigquery_project_name` and has `roles/bigquery.dataEditor` access on the dataset.
