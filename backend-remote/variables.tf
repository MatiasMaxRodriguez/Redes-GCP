variable "project_id" {
  type        = string
  description = "El ID del proyecto de Google Cloud donde se desplegará la VPC." 
}

variable "region" {
  type        = string
  description = "La región de Google Cloud donde se desplegará la VPC."
  default     = "us-central1"
}
