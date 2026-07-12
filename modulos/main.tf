# 1. Red de soporte para alojar las instancias creadas mediante el modulo
resource "google_compute_network" "vpc_network" {
    name = "vpc-red-de-soporte"
    auto_create_subnetworks = false  
}

resource "google_compute_subnetwork" "vpc_subnetwork" {
    name = "subnet-red-de-soporte"
    ip_cidr_range = "10.0.1.0/24"  
    network = google_compute_network.vpc_network.id  
    region = var.region  
}

resource "google_compute_firewall" "allow_http_ssh" {
    name = "allow-http-ssh"  
    network = google_compute_network.vpc_network.id  
    source_ranges = ["0.0.0.0/0"]  
    allow {
        protocol = "tcp"  
        ports = ["80", "22"]  
    }  
}

# 2. Llamada e instanciacion de nuestro modulo personalizado
module "web_server_1" {
    source = "./modules/gce_instance"
    instance_name = "modulo-web-server-1"
    subnet_id = google_compute_subnetwork.vpc_subnetwork.id  
    project_id = var.project_id 
    zone = var.zone

    # Pasar un script de inicio personalizado directamente desde la raiz
    startup_script = <<-EOF
        #!/bin/bash
        sudo apt-get update  
        sudo apt-get install -y nginx  
        sudo systemctl start nginx
        echo "<h1>Desplegado utilizando un modulo de Terraform</h1>" > /var/www/html/index.html
    EOF  
} 