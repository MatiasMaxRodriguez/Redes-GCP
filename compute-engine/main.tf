# 1. Crea una red VPC personalizada (requerida para alojar la VM de forma aislada)
resource "google_compute_network" "custom_vpc" {
    name = "vpc-ce" 
    auto_create_subnetworks = false # False porque crearemos una subnet manualmente 
}   

# 2. Crea una subnet dentro de la VPC personalizada
resource "google_compute_subnetwork" "custom_subnet" {
    name          = "subnet-ce" 
    network       = google_compute_network.custom_vpc.id
    ip_cidr_range = "10.10.10.0/24" # Rango de IPs que se usarán en la red 
    region        = var.region
}   

# Reglas de firewall permitir SSH y HTTP
resource "google_compute_firewall" "allow_ssh_http" {
    name    = "allow-ssh-http-ce"  
    network = google_compute_network.custom_vpc.id

    allow {
        protocol = "tcp" 
        ports    = ["22", "80"] # Permite el tráfico en los puertos 22 (SSH) y 80 (HTTP)
    }   

    source_ranges = ["0.0.0.0/0"] # Permite el tráfico desde cualquier IP (para pruebas)
}

# 4. Instancia de Compute Engine (Con script de inicio)
resource "google_compute_instance" "web_server_ce" {
    name         = "web-server-ce"
    machine_type = var.machine_type
    zone         = var.zone

    # Boot disk ( Disco de arranque )
    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-11" # Imagen base de Linux
        }   
    } 

    # Red y networking
    network_interface {
        network = google_compute_network.custom_vpc.id
        subnetwork = google_compute_subnetwork.custom_subnet.id

        # Asigna una IP pública para poder acceder desde internet
        access_config {
            // Ephemeral public IP 
        } 
    } 

    # Script de inicio (archivo startup.sh)
    metadata_startup_script = file("startup.sh")
}

