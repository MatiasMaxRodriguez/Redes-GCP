output "vpc_created_name" {
    value = google_compute_network.vpc_custom.name
    description = "Nombre de la VPC creada."
}

# Output avanzado estructurado dinamicamente a traves de un bucle for
output "deployed_subnets_summary" {
    value = { for name, subnet in google_compute_subnetwork.vpc_subnets : name   => {
        id          = subnet.id
        cidr_range  = subnet.ip_cidr_range
        region      = subnet.region
    }}
    description = "Detalles completos de las subredes creadas dinamicamente."
}