# Terraform module(s) for Aiven Kafka Connect
Modules for provisioning various Kafka connectors onto an Aiven managed KafkaConnect cluster

## Getting started
Access to Aiven terraform provider requires an API authentication token which can be generated from [Aiven console](https://console.gcp.aiven.io/profile/auth)
The owner of the API Authentication token should have admin permissions.
Export the token in an environment variable `TF_VAR_api_token`

## Modules

- [Google BigQuery sink connector](modules/bigquery-sink)

