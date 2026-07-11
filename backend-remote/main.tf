resource "random_id" "bucket_suffix" {
    byte_length = 4
}

# Bucket GCS dedicado a guardar el archivo de estado de terraform
resource "google_storage_bucket" "state_bucket" {
    name = "terramadre-${random_id.bucket_suffix.hex}"
    location = "US"
    storage_class = "STANDARD"
    
    # Habilita el versionamiento
    versioning {
        enabled = true
    }
    
    # Habilita el bloqueo a nivel de bucket
    uniform_bucket_level_access = true
    
    # Habilita la prevención de acceso público
    public_access_prevention = "enforced"

}