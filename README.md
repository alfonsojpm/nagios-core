# Nagios Core Docker Image

Este proyecto contiene un Dockerfile que construye una imagen de Docker con **Nagios Core** preinstalado y configurado para ejecutarse dentro de un contenedor en un entorno Debian Slim.

---

## Requisitos Previos

Antes de comenzar, asegúrate de tener instalado en tu sistema:

- Docker
- Git (opcional, si clonas este repositorio)

---

## Construcción de la imagen

1. Clona este repositorio o descarga los archivos Dockerfile, start.sh y README.md en una carpeta local:

git clone https://github.com/tu_usuario/nagios-docker.git
cd nagios-docker

2. Construye la imagen ejecutando:

docker build -t nagios-core .

Esto ejecutará las siguientes acciones:
- Instala todas las dependencias necesarias (Apache, PHP, utilidades de compilación, etc.)
- Descarga y compila Nagios Core desde el código fuente
- Crea un usuario nagiosadmin con contraseña nagiosadmin
- Configura Apache para servir la interfaz web de Nagios
- Expondrá el puerto 80 para acceso web

---

## Ejecución del contenedor

Una vez construida la imagen, puedes ejecutarla con:

docker run -d -p 80:80 --name nagios nagios-core

Este comando:
- Inicia el contenedor en segundo plano (-d)
- Mapea el puerto 80 del contenedor al puerto 80 de tu máquina
- Le asigna el nombre nagios al contenedor

---

## Acceso a la interfaz web

Una vez iniciado el contenedor, abre tu navegador y visita:

http://localhost/nagios

Credenciales por defecto:
- Usuario: nagiosadmin
- Contraseña: nagiosadmin

Importante: Para entornos productivos, cambia estas credenciales editando el Dockerfile o accediendo directamente al archivo /usr/local/nagios/etc/htpasswd.users dentro del contenedor.

---

## Limpieza del entorno (opcional)

Para detener y eliminar el contenedor:

docker stop nagios

docker rm nagios

Para eliminar la imagen construida:

docker rmi nagios-core

---

## Archivos del proyecto

- Dockerfile: Define la imagen y los pasos para instalar y configurar Nagios Core.
- start.sh: Script que inicia Apache y Nagios dentro del contenedor.
- README.md: Este documento.

---

## Contacto

Mantenedor: Alfonso Pumar
