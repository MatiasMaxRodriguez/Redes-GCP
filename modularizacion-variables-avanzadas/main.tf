# 1. Red de VPC Personalizada utilizando un nombre dinamico calculado en locals
resource "google_compute_network" "vpc_custom" {
    name                    = local.vpc_name
    auto_create_subnetworks = false
}   

# 2. Creacion dinamica de subredes utilizando un bucle for-each
resource "google_compute_subnetwork" "vpc_subnets" {
    for_each = var.subnets   
    name          = each.key
    network       = google_compute_network.vpc_custom.id
    region        = each.value.region
    ip_cidr_range = each.value.cidr_range
}   

# 3. Recurso auxiliar para asegurar unicidad
resource "random_id" "unique_suffix" {
    byte_length = 4
}       

# 4. Bucket de almacenamiento para demostrar la herencia de etiquetas de locals
resource "google_storage_bucket" "labeled_bucket" {
    name = "bucket-labels-${local.environment}-${random_id.unique_suffix.hex}"
    location = "US"
    force_destroy = true 
    uniform_bucket_level_access = true

    # Aplicacion de metadatos comunes estructurados en locals
    labels = local.common_labels  
}   
