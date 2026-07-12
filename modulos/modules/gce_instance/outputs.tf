output "public_ip" {
    value = google_compute_instance.gce_instance.network_interface[0].access_config[0].nat_ip
    description = "IP publica de la instancia"
}

output "instance_name" {
    value = google_compute_instance.gce_instance.name
    description = "Nombre de la instancia"  
}