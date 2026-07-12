locals {
    environment = "dev"
    owner = "equipo-devops"

    # Concatenacion dinamica para estandarizar el nombre de la VPC
    vpc_name = "vpc-${var.project_id}-${local.environment}"

    # Diccionario de etiquetas comunes que aplicaremos a los recursos complejos
    common_labels = {
        env         = local.environment
        owner       = local.owner
        project     = var.project_id
        managed     = "terraform"
    } 
}

  