# Práctica 2.1: Instalación y configuración de servidor web Nginx con Docker

## 1. Introducción

Esta parte de la práctica la ha realizado **Raúl Labrador Pérez**, obviamente **Álvaro Becerril** también ha participado y observado el proceso, pero lo que es realizar la escritura de los comandos, la configuración y este Readme ha sido realizado por **Raúl**.

Es por esto que en esta parte example.test pasa a ser raul.test 

## 2. Instalación de Docker

Como esta práctica ha sido realizada en mi portatil (Windows 11), el cuál es el que uso para clase ya tenía instaldo Docker.
![VagrantFile](/img/Docker-img/version.png)

## 3. Creación de la estructura de carpetas del sitio web
Como indica en el pdf, tenemos que crear dos carpetas, por tanto he copiado los comandos tal cual
![VagrantFile](/Nginx-Alvaro_Becerril-Ra-l_Labrador/img/Docker-img/crear-carpetas.png)

Ahora dentro de la carpeta html tenemos que **clonar** el repositorio que vemos en el pdf.
![VagrantFile](/Nginx-Alvaro_Becerril-Ra-l_Labrador/img/Docker-img/clonar-repo.png)

## 4. Configuración de servidor web NGINX con Docker
Como vemos tenemos que crear un archivo de configuración que se llama nginx.conf donde meteremos la configuración explicada en el pdf, con la diferencia que en: `server_name`, tenemos que cambiar el `example.test` por `raul.test`
![VagrantFile](/Nginx-Alvaro_Becerril-Ra-l_Labrador/img/Docker-img/nginx-conf.png)

Y aqui vemos como quedaria la configuración cambiada.
![VagrantFile](/Nginx-Alvaro_Becerril-Ra-l_Labrador/img/Docker-img/nginx-conf-cambiada.png)

### 4.2 Crear y ejecutar el contendor Docker
Los únicos cambios que he realizado respecto al pdf son: cambiar donde pone `example` por `raul`, para indicar que son mis archivos y que no nos de error.
![VagrantFile](/Nginx-Alvaro_Becerril-Ra-l_Labrador/img/Docker-img/ejecutar-contendor.png)

Ahora solo tenemos que comprobar que el contenedor se este ejecutando
![VagrantFile](/Nginx-Alvaro_Becerril-Ra-l_Labrador/img/Docker-img/contendor-ejecutado.png)

Y ver los logs del contenedor
![VagrantFile](/Nginx-Alvaro_Becerril-Ra-l_Labrador/img/Docker-img/contendor-logs.png)

## 5. Comprobación del correcto funcionamiento
Aquí podemos ver la como la página carga perfectamente desde el `localhost`.
![VagrantFile](/Nginx-Alvaro_Becerril-Ra-l_Labrador/img/Docker-img/comprobacion-funcionando.png)

### 5.1.1 Editar archivo hosts
Vamos a editar el archivo `hosts`, para que el `localhost` apunte a la ip de nuestro servidor
![VagrantFile](/Nginx-Alvaro_Becerril-Ra-l_Labrador/img/Docker-img/editar-hosts.png)

### 5.2 Comprobar registros del servidor
Como podemos ver no tenemos ningún problema con los registros de nuestro servidor y todo funciona correctamente.
![VagrantFile](/Nginx-Alvaro_Becerril-Ra-l_Labrador/img/Docker-img/comprobar-registros.png)

## 6.Gestión del contenedor
Vamos a ver los diferentes comandos de gestión de nuestro contenedor, como son `stop`, `restart` y `rm`: 
![VagrantFile](/Nginx-Alvaro_Becerril-Ra-l_Labrador/img/Docker-img/gestion-stop.png)
![VagrantFile](/Nginx-Alvaro_Becerril-Ra-l_Labrador/img/Docker-img/gestion-restart.png)
![VagrantFile](/Nginx-Alvaro_Becerril-Ra-l_Labrador/img/Docker-img/gestion-rm.png)

## 7. Alternativa: Usando Docker Compose
Esta sección aunque es una alternativa, queríamos hacerla también para seguir práticando con el `docker-compose.yml` de Docker.

Lo primero que tenemos que hacer es crear el archivo `docker-compose.yml`

![VagrantFile](/Nginx-Alvaro_Becerril-Ra-l_Labrador/img/Docker-img/docker-compose.png)

Una vez que lo tenemos, tenemos que añadirle la configuración necesaria para que funcione perfectamente.
![VagrantFile](/Nginx-Alvaro_Becerril-Ra-l_Labrador/img/Docker-img/docker-conf.png)

Una vez que lo tenemos, simplemente es levantarlo, ver sus logs si lo queremos y cuando queramos pararlo.
![VagrantFile](/Nginx-Alvaro_Becerril-Ra-l_Labrador/img/Docker-img/composer-up.png)
![VagrantFile](/Nginx-Alvaro_Becerril-Ra-l_Labrador/img/Docker-img/composer-logs.png)
![VagrantFile](/Nginx-Alvaro_Becerril-Ra-l_Labrador/img/Docker-img/composer-down.png)