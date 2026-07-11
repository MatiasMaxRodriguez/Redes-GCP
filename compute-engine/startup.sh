#!/bin/bash
# Actualizar el gestor de paquetes e instalar Apache
apt-get update
apt-get install -y apache2

# Iniciar y habilitar el servicio Apache
systemctl start apache2
systemctl enable apache2

# Crear un archivo HTML personalizado de bienvenida
echo '<!DOCTYPE html>
<html>
<head><title>Apache en GCP</title></head>
<body>
    <h1>Apache esta funcionando correctamente en Google Cloud. </h1>
    <p>Esta es una pagina servida desde una instancia de VM de Compute Engine.</p>
</body>
</html>' > /var/www/html/index.html # > es para redirigir el contenido del archivo 