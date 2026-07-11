variable "project_id" {
  type        = string
  description = "El ID del proyecto en GCP"
}

variable "region" {
  type        = string
  description = "La región en GCP"
  default = "us-central1"
}

variable "bucket_prefix" {
  type        = string
  description = "El prefijo del nombre del bucket en GCS"
  default = "gcp-terraform-ag"
}

variable "storage_class" {
  type        = string
  description = "El tipo de almacenamiento en GCS"
  default = "STANDARD"
}
