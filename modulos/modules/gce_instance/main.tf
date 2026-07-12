resource "google_compute_instance" "gce_instance" {
    name = var.instance_name
    machine_type = var.machine_type
    zone = var.zone

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-11"
        }
    }

    network_interface {
        subnetwork = var.subnet_id
        # Habilita la IP publica efimera  
        access_config {}
    }
    metadata_startup_script = var.startup_script
}
    