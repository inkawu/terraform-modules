terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.12.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_cloud_run_service" "main" {
  name     = var.app_name
  location = var.region

  template {
    spec {
      containers {
        image = var.container_image

        ports {
          name           = var.ports["name"]
          container_port = var.ports["port"]
        }

        dynamic "env" {
          for_each = var.env
          content {
            name  = env.value["name"]
            value = env.value["value"]
          }
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location = google_cloud_run_service.main.location
  project  = google_cloud_run_service.main.project
  service  = google_cloud_run_service.main.name

  policy_data = data.google_iam_policy.noauth.policy_data
}

resource "google_cloud_run_domain_mapping" "main" {
  location = var.region
  name     = var.domain

  metadata {
    namespace = var.project_id
  }

  spec {
    route_name = google_cloud_run_service.main.name
  }

  depends_on = [
    google_cloud_run_service_iam_policy.noauth,
    google_cloud_run_service.main
  ]
}
