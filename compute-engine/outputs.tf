output "instance_public_ip" {
    description = "Dirección IP pública de la instancia"
    value       = google_compute_instance.web_server_ce.network_interface[0].access_config[0].nat_ip
}
