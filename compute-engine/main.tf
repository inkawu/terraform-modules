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

  network_interface {
    network = "default"
  }
}
