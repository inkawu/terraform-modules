variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "app_name" {
  type = string
}

variable "env" {
  type = list(object({
    value = string
    name  = string
  }))
  description = "Environment variables (cleartext)"
  default     = []
}

variable "ports" {
  type = object({
    name = string
    port = number
  })
  description = "Port which the container listens to (http1 or h2c)"
  default = {
    name = "http1"
    port = 8080
  }
}

variable "domain" {
  type = string
}

variable "container_image" {
  type = string
}
