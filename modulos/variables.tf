variable "project_id" {
    type = string
    description = "ID del proyecto"
}   

variable "region" {
    type = string
    default = "us-central1"  
    description = "Region de la instancia"  
}       

variable "zone" {
    type = string
    default = "us-central1-a"  
    description = "Zona de la instancia"  
}   
