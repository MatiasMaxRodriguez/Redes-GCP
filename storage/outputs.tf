output "gcs_bucket_name" {
  value       = google_storage_bucket.gcs_bucket.name
  description = "El nombre del bucket en GCS"
}   

output "gcs_bucket_url" {
  value       = google_storage_bucket.gcs_bucket.url
  description = "La URL del bucket en GCS"    
}

output "gcs_bucket_location" {
  value       = google_storage_bucket.gcs_bucket.location
  description = "La ubicación del bucket en GCS"    
}       