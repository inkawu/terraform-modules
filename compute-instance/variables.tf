variable "name" {
  type = string
}

variable "boot_disk_size" {
  type = number
}

variable "machine_type" {
  type = string
}

variable "boot_disk_type" {
  type = string
}

variable "image" {
  type = string
}

variable "container_image" {
  type = string
}

variable "env_vars" {
  type = list(object({
    name  = string
    value = string
  }))
}
