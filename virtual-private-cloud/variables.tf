variable "project_id" {
  type        = string
  description = "El ID del proyecto de Google Cloud donde se desplegará la VPC."
  default     = "gcp-terraform-ag"  
}

variable "region" {
  type        = string
  description = "La región de Google Cloud donde se desplegará la VPC."
  default     = "us-central1"
}

variable "vpc_name" {
  type        = string
  description = "El nombre de la VPC."
  default     = "mmr-vpc"
}

variable "subnet_cidr" {
  type        = string
  description = "El rango de CIDR de la subred."
  default     = "10.10.10.0/24"  
}