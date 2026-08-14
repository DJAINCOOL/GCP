variable "project_id" {
  type = string
}

variable "image" {
  type    = string
  default = "debian-cloud/debian-11"
}

variable "instances" {
  type = list(object({
    name        = string
    machine_type = optional(string, "e2-medium")
    zone        = string
    subnetwork  = string
  }))
}

resource "google_compute_instance" "vm" {
  for_each    = { for inst in var.instances : inst.name => inst }
  name        = each.value.name
  project     = var.project_id
  zone        = each.value.zone
  machine_type = each.value.machine_type

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    subnetwork = each.value.subnetwork
    access_config {}
  }
}

output "instances" {
  value = { for k, v in google_compute_instance.vm : k => v.self_link }
}
