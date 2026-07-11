variable "project_id" {
  type        = string
  description = "El ID del proyecto de Google Cloud donde se desplegará la VPC."  
}

variable "region" {
  type        = string
  description = "La región de Google Cloud donde se desplegará la VPC."
  default     = "us-central1"
}

variable "zone" {
  type        = string
  description = "La zona de Google Cloud donde se desplegará la VPC."
  default     = "us-central1-a"
} 

variable "machine_type" {
  type        = string
  description = "El tipo de máquina que se utilizará para la instancia de Compute Engine."
  default     = "e2-micro" 
} 
