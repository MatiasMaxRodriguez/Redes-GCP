output "db_instance_name" {
  value       = google_sql_database_instance.private_sql_db.name
  description = "Nombre de la instancia de base de datos"
}

output "db_private_ip" {
  value       = google_sql_database_instance.private_sql_db.private_ip_address
  description = "IP privada de la instancia de base de datos"
}

output "db_connection_name" {
  value       = google_sql_database_instance.private_sql_db.connection_name
  description = "Nombre de conexion de la instancia de base de datos para herramientas de proxy"
}