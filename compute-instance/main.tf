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

  metadata = {
    "gce-container-declaration" = "# DISCLAIMER:\n# This container declaration format is not a public API and may change without\n# notice. Please use gcloud command-line tool or Google Cloud Console to run\n# Containers on Google Compute Engine.\n\nspec:\n  containers:\n  - env: ${jsonencode(var.env_vars)}\n    image: ${var.container_image}\n    name: instance-1\n    securityContext:\n      privileged: false\n    stdin: false\n    tty: false\n    volumeMounts: []\n  restartPolicy: Always\n  volumes: []\n"
    "google-logging-enabled"    = "true"
  }

  network_interface {
    network = "default"
  }
}
