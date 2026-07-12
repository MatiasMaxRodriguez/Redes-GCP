variable "project_id" {
  type        = string
  description = "El ID del proyecto de Google Cloud donde se desplegará la VPC."  
}

variable "region" {
  type        = string
  description = "La región de Google Cloud donde se desplegará la VPC."
  default     = "us-central1"
}

# Variable compleja para definir multiples subredes dinamicamente
variable "subnets" {
    type = map(object({
        cidr_range  = string
        region      = string        
    }))
    description = "Mapa de subredes a crear con sus respectivos rangos CIDR y regiones"
    default     = {
        "web-subnet-01" = {
            cidr_range = "10.0.1.0/24"
            region     = "us-central1"
        },
        "app-subnet-01" = {
            cidr_range = "10.0.2.0/24"
            region     = "us-central1"
        }
    }
}