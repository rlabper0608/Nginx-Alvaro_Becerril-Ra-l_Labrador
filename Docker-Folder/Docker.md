Práctica 2.1: Instalación y configuración de servidor web Nginx con Docker

1. Introducción

Esta parte de la práctica la ha realizado Raúl Labrador Pérez, obviamente Álvaro Becerril también ha participado y observado el proceso, pero lo que es realizar la escritura de los comandos, la configuración y este Readme ha sido realizado por Raúl.

Es por esto que en esta parte example.test pasa a ser raul.test 

2. Instalación de Docker

Como esta práctica ha sido realizada en mi portatil (Windows 11), el cuál es el que uso para clase ya tenía instaldo Docker.
![VagrantFile](img/Docker-img/version.png)

3. Creación de la estructura de carpetas del sitio web
Como indica en el pdf, tenemos que crear dos carpetas, por tanto he copiado los comandos tal cual
![VagrantFile](img/Docker-img/crear-carpetas.png)

Ahora dentro de la carpeta html tenemos que clonar el repositorio que vemos en el pdf.
![VagrantFile](img/Docker-img/clonar-repo.png)

4. Configuración de servidor web NGINX con Docker
Como vemos tenemos que crear un archivo de configuración que se llama nginx.conf donde meteremos la configuración explicada en el pdf, con la diferencia que en: server_name, tenemos que cambiar el example.test por raul.test
![VagrantFile](img/Docker-img/nginx-conf.png)

Y aqui vemos como quedaria la configuración cambiada.
![VagrantFile](img/Docker-img/nginx-conf-cambiada.png)

4.2 Crear y ejecutar el contendor Docker
Los únicos cambios que he realizado respecto al pdf son: cambiar donde pone example por raul, para indicar que son mis archivos y que no nos de error.
![VagrantFile](img/Docker-img/ejecutar-contendor.png)

Ahora solo tenemos que comprobar que el contenedor se este ejecutando
![VagrantFile](img/Docker-img/contendor-ejecutado.png)

Y ver los logs del contenedor
![VagrantFile](img/Docker-img/contendor-logs.png)
