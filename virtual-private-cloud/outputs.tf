output "vpc_name" {
  value       = google_compute_network.custom_vpc.name
  description = "El nombre de la VPC."
}

output "vpc_id" {
  value       = google_compute_network.custom_vpc.id
  description = "El ID de la VPC."
}   

output "subnet_name" {
  value       = google_compute_subnetwork.custom_subnet.name
  description = "El nombre de la subred."
}

output "subnet_id" {
  value       = google_compute_subnetwork.custom_subnet.id
  description = "El ID de la subred."
}