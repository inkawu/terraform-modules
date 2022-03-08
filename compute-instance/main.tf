resource "google_service_account" "artifact-reader" {
  account_id   = "${var.name}-artifact-reader"
  display_name = "Artifact reader service account for ${var.name} compute instance"
}

resource "google_service_account_iam_member" "admin-account-iam" {
  service_account_id = google_service_account.artifact-reader.name
  role               = "roles/artifactregistry.reader"
  member             = "serviceAccount:${google_service_account.artifact-reader.email}"
}

resource "google_compute_instance" "main" {
  name         = var.name
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      size  = var.boot_disk_size
      image = var.image
      type  = var.boot_disk_type
    }
  }

  metadata_startup_script = <<EOT
    docker run -e ${join(" -e ", var.env_vars)} ${var.container_image}
  EOT


  network_interface {
    network = "default"

    access_config {}
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.artifact-reader.email
    scopes = ["cloud-platform"]
  }
}
