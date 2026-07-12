variable "instance_name" {
    type = string
    description = "Nombre de la instancia"
}

variable "project_id" {
    type = string
    description = "ID del proyecto"
}

variable "zone" {
    type = string
    description = "Zona de la instancia"
    default = "us-central1-a"
}

variable "machine_type" {
    type = string
    description = "Tipo de maquina"
    default = "e2-micro"
}

variable "startup_script" {
    type = string
    description = "Script de inicio"
    default = ""    
}

variable "subnet_id" {
    type = string
    description = "El ID de la subred donde se desplegará el servidor"
}

