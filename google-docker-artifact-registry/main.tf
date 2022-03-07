resource "google_artifact_registry_repository" "main" {
  provider      = google-beta
  repository_id = var.repository_id
  location      = var.region
  format        = "DOCKER"
}
