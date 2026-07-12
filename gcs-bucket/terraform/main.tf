# Genera una cadena aleatoria para garantizar la unicidad del nombre del bucket
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# Crear el Bucket de almacenamiento
resource "google_storage_bucket" "test_bucket" {
  name          = "test-bucket-${random_id.bucket_suffix.hex}"  
  location      = var.region
  uniform_bucket_level_access = true
  force_destroy = true # Para desarrollo, permite eliminar aunque tenga contenido
  public_access_prevention = "enforced"  
}

# Muestra en la terminal el nombre del bucket creado
output "bucket_name" {
  value       = google_storage_bucket.test_bucket.name
  description = "Nombre del bucket creado"  
}
