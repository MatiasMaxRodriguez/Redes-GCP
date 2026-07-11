# Generador de sufijo aleatorio para asegurar la unicidad global del nombre del bucket
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# Creación del bucket GCS con el sufijo aleatorio
resource "google_storage_bucket" "gcs_bucket" {
  name          = "${var.bucket_prefix}-${random_id.bucket_suffix.hex}"
  location      = "US"
  uniform_bucket_level_access = true
  force_destroy = true
  storage_class = "STANDARD"
  public_access_prevention = "enforced" # Seguridad: Previene la configuración de ACLs públicas en el bucket

  versioning {
    enabled = true # Resiliencia: Habilita el control de versiones de los archivos. Evita pérdida de estado por borrado accidental.
  }

  # Regla de ciclo de vida 1: Transicion de Standard a Nearline
  lifecycle_rule {
    condition {
      age = 30 # Transiciona a Nearline después de 30 días
    }
    action {
      type = "SetStorageClass" 
      storage_class = "NEARLINE"
    }
  }

  # Regla de ciclo de vida 2: Depuracion de versiones obsoletas
  lifecycle_rule {
    condition {
      days_since_noncurrent_time = 90 # Elimina versiones no actuales después de 90 días
      with_state = "ANY"    
    }
    action {
      type = "Delete" 
    }
  }     
}   
