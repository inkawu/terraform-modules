resource "google_service_account" "default" {
  account_id   = "artifact-reader"
  display_name = "Artifact reader service account"
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
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}
