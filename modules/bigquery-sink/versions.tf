terraform {
  required_providers {
    aiven = {
      source  = "aiven/aiven"
      version = ">= 3.0.0, < 4.0.0"
    }
    google = {
      source  = "hashicorp/google"
      version = ">=4.39.0"
    }
  }
  required_version = ">=0.13.2"
}

provider "aiven" {
  api_token = var.aiven_api_token
}
