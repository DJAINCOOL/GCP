output "network_self_link" {
  value = google_compute_network.network.self_link
}

output "subnets" {
  value = { for k, s in google_compute_subnetwork.subnets : k => s.self_link }
}
