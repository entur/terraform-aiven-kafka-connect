# Google BigQuery sink connector module

A terraform-module for provisioning Google BigQuery sink connector onto an Aiven managed KafkaConnect cluster.
This module depends on [Aiven kafka init module](https://github.com/entur/terraform-aiven-kafka-connect-init) to access
basic information about Aiven's KafkaConnect cluster

[Module](modules/bigquery-sink)

[Example](examples/minimal/main.tf)

## Getting started

Access to Aiven terraform provider requires an API authentication token which can be generated
from [Aiven console](https://console.gcp.aiven.io/profile/auth)
Aiven authentication token can be provided as an environment variable with `TF_VAR_` prefix or in a `.tfvars` file,
otherwise from Harness Secrets Manager if you are provisioning from Harness.

### BigQuery configuration

To be able to sink to a BigQuery project you need a BigQuery project and a dataset created beforehand.
And you need a service account that has BigQueryEditor access to be able to create tables inside that dataset.
Each connector will add a key to that service account and provides the key as JSON to the connector for authentication.
Key will be destroyed along with the connector.

<!-- ci: x-release-please-start-version -->

### Example using the latest release

```
module "bigquery-sink" {
  source = "github.com/entur/terraform-aiven-kafka-connect-bigquery-sink//modules/bigquery-sink?ref=v0.1.1"
  ...
}
```

<!-- ci: x-release-please-end -->

See the [`README.md`](modules/bigquery-sink/README.md)  under module's subfolder for a list of supported inputs and
outputs. For examples showing how they're implemented, check the [examples](examples) subfolder.

### Version constraints

You can control the version of a module dependency by adding `?ref=TAG` at the end of the source argument, as shown in
the example above. This is highly recommended. You can find a list of available
versions [here](https://github.com/entur/terraform-aiven-kafka-connect-bigquery-sink/releases).

Dependency automation tools such as Renovate Bot will be able to discover new releases and suggest updates
automatically.

## Reference(s)

- [Aiven's Google BigQuery sink connector](https://docs.aiven.io/docs/products/kafka/kafka-connect/howto/gcp-bigquery-sink)
- [Git repo for Kafka Connect BigQuery Connector](https://github.com/confluentinc/kafka-connect-bigquery)
