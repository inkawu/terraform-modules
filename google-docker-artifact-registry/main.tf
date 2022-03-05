terraform {
  required_providers {
    google = {
      source  = "hashicorp/google-beta"
      version = "4.12.0"
    }
  }
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

resource "google_artifact_registry_repository" "main" {
  repository_id = var.repository_id
  description   = var.description
  format        = "DOCKER"
}
