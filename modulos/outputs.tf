output "web_server_ip" {
    description = "IP publica de la instancia"  
    value = module.web_server_1.public_ip
}
    