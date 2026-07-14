# 1. Habilitacion de APIs de Google Cloud requeridas para el laboratorio
resource "google_project_service" "apis" {
  for_each = toset([
    "sqladmin.googleapis.com",
    "servicenetworking.googleapis.com"
  ])
  project = var.project_id
  service = each.value
  disable_on_destroy = false 
}

# 2. Red VPC personalizada
resource "google_compute_network" "vpc_database" {
  name = "sql-vpc-database"
  auto_create_subnetworks = false
}

# 3. Subred basica para recursos locales (opcional, para futuras VMs)
resource "google_compute_subnetwork" "vpc_subnet_db" {
  name          = "sql-vpc-subnet-db"
  ip_cidr_range = "10.10.10.0/24"
  region        = var.region
  network       = google_compute_network.vpc_database.id
}

# 4. Reserva de rango IP interno para Private Service Access (PSA)
resource "google_compute_global_address" "private_ip_alloc" {
  name          = "sql-vpc-db-private-ip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16 # Reserva un bloque de /16 para servicios gestionados
  network       = google_compute_network.vpc_database.id
}

# 5. Creacion del Peering de red (Conexion de red de servicios)
resource "google_service_networking_connection" "database_vpc_peering" {
  network                 = google_compute_network.vpc_database.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]

  # Se asegura de esperar  a que la API de red de servicios este completamente habilitada
  depends_on = [google_project_service.apis]
}

# 6. Generador de sufijo aleatorio para asegurar la unicidad en el nombre de la instancia
resource "random_id" "db_suffix" {
  byte_length = 4 
}

# 7. instancia de la Base de Datos PostgreSQL privada
resource "google_sql_database_instance" "private_sql_db" {
  name             = "sql-db-postgres-${random_id.db_suffix.hex}"   # Nombre unico de la instancia
  database_version = "POSTGRES_16" # Versión de PostgreSQL
  region           = var.region 
  
  # Proteccion de borrado desactivada para facilitar pruebas de destruccion en el laboratorio
  deletion_protection = false
  
  settings {
    # Tipo de máquina para la instancia de base de datos
    tier = "db-f1-micro" # Tipo de maquina de bajo costo para pruebas
    edition = "ENTERPRISE" # Edicion Enterprise
    
    ip_configuration {
      ipv4_enabled = false # Deshabilitar IPv4
      private_network = google_compute_network.vpc_database.id
    } 
  }

  # Obligatorio esperar a que el peering se establezca antes de crear la base de datos
  depends_on = [google_service_networking_connection.database_vpc_peering]
}

# 8. Creacion de la Base de Datos dentro de la instancia
resource "google_sql_database" "database" {
  name     = "app_database"
  instance = google_sql_database_instance.private_sql_db.name
}

# 9. Creacion del usuario administrador de la base de datos
resource "google_sql_user" "db_user_admin" {
  name     = "app_admin"
  instance = google_sql_database_instance.private_sql_db.name
  password = "SuperPassword!" # En entornos reales se gestiona con Secret Manager
}