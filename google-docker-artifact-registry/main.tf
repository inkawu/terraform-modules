resource "google_artifact_registry_repository" "main" {
  repository_id = var.repository_id
  location      = var.region
  format        = "DOCKER"
}
