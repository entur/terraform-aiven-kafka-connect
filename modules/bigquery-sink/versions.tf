terraform {
  required_providers {
    aiven = {
      source = "aiven/aiven"
    }
    google = {
      source  = "hashicorp/google"
      version = ">=4.40.0"
    }
  }
  required_version = ">=0.13.2"
}

provider "aiven" {
  api_token = var.init.aiven.access_token
}
