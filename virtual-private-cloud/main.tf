# 1. Red VPC Personalizada
# auto_create_subnetworks se establece en false como buena practica de seguridad
resource "google_compute_network" "custom_vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

# 2. Subred Personalizada
resource "google_compute_subnetwork" "custom_subnet" {
  name          = "${var.vpc_name}-subnet-01"
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.custom_vpc.id
}

# 3. Crear reglas de firewall para permitir el trafico ICMP
resource "google_compute_firewall" "allow_icmp" {
  name    = "${var.vpc_name}-allow-icmp"
  network = google_compute_network.custom_vpc.name
  allow {
    protocol = "icmp"
  }
  source_ranges = ["0.0.0.0/0"]
}

# 4. Crear reglas de firewall para permitir el trafico SSH y HTTP
resource "google_compute_firewall" "allow_ssh_http" {
  name    = "${var.vpc_name}-allow-ssh-http"
  network = google_compute_network.custom_vpc.name
  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }
  source_ranges = ["0.0.0.0/0"]
}
