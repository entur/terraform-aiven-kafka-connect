# Terraform module(s) for Aiven Kafka Connect

Modules for provisioning various Kafka connectors onto an Aiven managed KafkaConnect cluster

## Getting started

Access to Aiven terraform provider requires an API authentication token which can be generated
from [Aiven console](https://console.gcp.aiven.io/profile/auth)
The owner of the API Authentication token should have admin permissions.
`api_token` with Aiven authentication token can be provided as an environment variable with `TF_VAR_` prefix or in
a `.tfvars` file, otherwise from Harness Secrets Manager if you are provisioning from Harness.

## Modules

- [Google BigQuery sink connector](modules/bigquery-sink)

