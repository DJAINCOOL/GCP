variable "network_name" {
  type = string
}

variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "subnets" {
  type = list(object({
    name = string
    cidr = string
  }))
}

resource "google_compute_network" "network" {
  name                    = var.network_name
  auto_create_subnetworks = false
  project                 = var.project_id
}

resource "google_compute_subnetwork" "subnets" {
  for_each       = { for s in var.subnets : s.name => s }
  name           = each.value.name
  ip_cidr_range  = each.value.cidr
  region         = var.region
  network        = google_compute_network.network.id
  project        = var.project_id
}
