# Usage

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.13.2 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >=4.40.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aiven"></a> [aiven](#provider\_aiven) | n/a |
| <a name="provider_google"></a> [google](#provider\_google) | >=4.40.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aiven_kafka_connector.bigquery-sink-connector](https://registry.terraform.io/providers/aiven/aiven/latest/docs/resources/kafka_connector) | resource |
| [google_service_account_key.bq-sa-key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_key) | resource |
| [google_service_account.bq-sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/service_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_configuration"></a> [additional\_configuration](#input\_additional\_configuration) | Add additional configuration options as a map | `map(string)` | `{}` | no |
| <a name="input_all_bigquery_fields_nullable"></a> [all\_bigquery\_fields\_nullable](#input\_all\_bigquery\_fields\_nullable) | If true, no fields in any produced BigQuery schema are REQUIRED. All non-nullable Avro fields are translated as NULLABLE (or REPEATED, if arrays) | `bool` | `true` | no |
| <a name="input_allow_bigquery_required_field_relaxation"></a> [allow\_bigquery\_required\_field\_relaxation](#input\_allow\_bigquery\_required\_field\_relaxation) | If true, fields in BigQuery Schema can be changed from REQUIRED to NULLABLE | `bool` | `true` | no |
| <a name="input_allow_new_bigquery_fields"></a> [allow\_new\_bigquery\_fields](#input\_allow\_new\_bigquery\_fields) | If true, new fields can be added to BigQuery tables during subsequent schema updates | `bool` | `true` | no |
| <a name="input_allow_schema_unionization"></a> [allow\_schema\_unionization](#input\_allow\_schema\_unionization) | If true, the existing table schema (if one is present) will be unionized with new record schemas during schema updates. If false, the record of the last schema in a batch will be used for any necessary table creation and schema update attempts | `bool` | `true` | no |
| <a name="input_auto_create_tables"></a> [auto\_create\_tables](#input\_auto\_create\_tables) | Automatically create BigQuery tables if they don’t already exist | `bool` | `true` | no |
| <a name="input_bigquery_dataset_name"></a> [bigquery\_dataset\_name](#input\_bigquery\_dataset\_name) | BigQuery dataset to sink data to | `string` | n/a | yes |
| <a name="input_bigquery_project_name"></a> [bigquery\_project\_name](#input\_bigquery\_project\_name) | BigQuery project id | `string` | n/a | yes |
| <a name="input_bigquery_retry_count"></a> [bigquery\_retry\_count](#input\_bigquery\_retry\_count) | The number of retry attempts made for a BigQuery request that fails with a backend error or a quota exceeded error | `number` | `1` | no |
| <a name="input_bigquery_service_account_id"></a> [bigquery\_service\_account\_id](#input\_bigquery\_service\_account\_id) | Service account id with google credentials in BigQuery project | `string` | n/a | yes |
| <a name="input_connector_class"></a> [connector\_class](#input\_connector\_class) | Name or alias of the class for this connector | `string` | `"com.wepay.kafka.connect.bigquery.BigQuerySinkConnector"` | no |
| <a name="input_connector_name"></a> [connector\_name](#input\_connector\_name) | Unique name for this connector in the connect cluster | `string` | n/a | yes |
| <a name="input_init"></a> [init](#input\_init) | Entur init module output. https://github.com/entur/terraform-aiven-kafka-connect-init | <pre>object({<br>    aiven = object({<br>      project      = string<br>      service      = string<br>      access_token = string<br>    })<br>    schema_registry = object({<br>      url      = string<br>      userinfo = string<br>    })<br>    default_configuration = map(string)<br>  })</pre> | n/a | yes |
| <a name="input_kafka_topics"></a> [kafka\_topics](#input\_kafka\_topics) | List of kafka topic names to sink data from | `list(string)` | n/a | yes |
| <a name="input_key_source_type"></a> [key\_source\_type](#input\_key\_source\_type) | Determines whether the keyfile configuration is the path to the credentials JSON file or to the JSON itself. Available values are FILE, JSON & APPLICATION\_DEFAULT | `string` | `"JSON"` | no |
| <a name="input_sanitize_topics"></a> [sanitize\_topics](#input\_sanitize\_topics) | Designates whether to automatically sanitize topic names before using them as table names. If not enabled, topic names are used as table names | `bool` | `true` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
