# Práctica 2.1: Instalación y configuración de servidor web Nginx con Docker

## 1. Introducción

Esta parte de la práctica la ha realizado **Raúl Labrador Pérez**, obviamente **Álvaro Becerril** también ha participado y observado el proceso, pero lo que es realizar la escritura de los comandos, la configuración y este Readme ha sido realizado por **Raúl**.

Es por esto que en esta parte example.test pasa a ser raul.test 

## 2. Instalación de Docker

Como esta práctica ha sido realizada en mi portatil (Windows 11), el cuál es el que uso para clase ya tenía instaldo Docker.
![VagrantFile](/img/Docker-img/version.png)

## 3. Creación de la estructura de carpetas del sitio web
Como indica en el pdf, tenemos que crear dos carpetas, por tanto he copiado los comandos tal cual
![VagrantFile](/img/Docker-img/crear-carpetas.png)

Ahora dentro de la carpeta html tenemos que **clonar** el repositorio que vemos en el pdf.
![VagrantFile](/img/Docker-img/clonar-repo.png)

## 4. Configuración de servidor web NGINX con Docker
Como vemos tenemos que crear un archivo de configuración que se llama nginx.conf donde meteremos la configuración explicada en el pdf, con la diferencia que en: `server_name`, tenemos que cambiar el `example.test` por `raul.test`
![VagrantFile](/img/Docker-img/nginx-conf.png)

Y aqui vemos como quedaria la configuración cambiada.
![VagrantFile](/img/Docker-img/nginx-conf-cambiada.png)

### 4.2 Crear y ejecutar el contendor Docker
Los únicos cambios que he realizado respecto al pdf son: cambiar donde pone `example` por `raul`, para indicar que son mis archivos y que no nos de error.
![VagrantFile](/img/Docker-img/ejecutar-contendor.png)

Ahora solo tenemos que comprobar que el contenedor se este ejecutando
![VagrantFile](/img/Docker-img/contendor-ejecutado.png)

Y ver los logs del contenedor
![VagrantFile](/img/Docker-img/contendor-logs.png)

## 5. Comprobación del correcto funcionamiento
Aquí podemos ver la como la página carga perfectamente desde el `localhost`.
![VagrantFile](/img/Docker-img/comprobacion-funcionando.png)

### 5.1.1 Editar archivo hosts
Vamos a editar el archivo `hosts`, para que el `localhost` apunte a la ip de nuestro servidor
![VagrantFile](/img/Docker-img/editar-hosts.png)

### 5.2 Comprobar registros del servidor
Como podemos ver no tenemos ningún problema con los registros de nuestro servidor y todo funciona correctamente.
![VagrantFile](/img/Docker-img/comprobar-registros.png)

## 6.Gestión del contenedor
Vamos a ver los diferentes comandos de gestión de nuestro contenedor, como son `stop`, `restart` y `rm`: 
![VagrantFile](/img/Docker-img/gestion-stop.png)
![VagrantFile](/img/Docker-img/gestion-restart.png)
![VagrantFile](/img/Docker-img/gestion-rm.png)

## 7. Alternativa: Usando Docker Compose
Esta sección aunque es una alternativa, queríamos hacerla también para seguir práticando con el `docker-compose.yml` de Docker.

Lo primero que tenemos que hacer es crear el archivo `docker-compose.yml`

![VagrantFile](/img/Docker-img/docker-compose.png)

Una vez que lo tenemos, tenemos que añadirle la configuración necesaria para que funcione perfectamente.
![VagrantFile](/img/Docker-img/docker-conf.png)

Una vez que lo tenemos, simplemente es levantarlo, ver sus logs si lo queremos y cuando queramos pararlo.
![VagrantFile](/img/Docker-img/composer-up.png)
![VagrantFile](/img/Docker-img/composer-logs.png)
![VagrantFile](/img/Docker-img/composer-down.png)


# Práctica 2.2: Autenticación en Nginx con Docker
## 1. Introducción
### 1.1. Lo primero que tenemos que hacer es descargarnos los paquetes que vamos a usar la segunda parte de esta práctica.
Tenemos que descargarnos staker/ssl-certs-generator, y lo vamos a hacer con un `docker pull`
![VagrantFile](/img/Docker-img/descargar-ssl-certs.png) 

### 1.2. Creación de usuarios y contraseñas para el acceso web
Tenemos que crear un archivo llamado `htpasswd` donde vamos a meter los usuarios y contraseñas, este archivo lo creamos dentro de la carpeta de `conf`.
![VagrantFile](/img/Docker-img/crear-htpasswd.png)

Para crear ahora la contraseña de forma no intreactica vamos a usar el siguiente comando: 
![VagrantFile](/img/Docker-img/crear-contrasena.png)

Aqui vemos la contraseña que nos ha generado.
![VagrantFile](/img/Docker-img/contrasena-generada.png)

Ahora vamos a crear otro usuario más con mi apellido y le vamos a generar una contraseña de la misma forma.
![VagrantFile](/img/Docker-img/crear-usuario-2.png)

### 1.3. Configurando el contenedor Nginx para usar autenticación básica
En mi caso yo si tengo un archivo de configuración por tanto no me hace falta extraerlo de la imagen. Mi archivo se llama `nginx.conf` y está en la carpeta `conf`.

Por tanto solo tengo que modifcar el archivo `nginx.conf` (en mi caso con un notepad y no nano) para que incluya la siguiente configuración: 
![VagrantFile](/img/Docker-img/nginx-conf-autenticacion.png)

Una vez que lo tenemos, ejecutamos el siguiente comando: `docker run -d --name nginx-raul -p 8080:80 -v ./conf/nginx.conf:/etc/nginx/conf.d/default.conf -v ./conf/htpasswd:/etc/nginx/.htpasswd -v ./html:/usr/share/nginx/html nginx` y vemos la respuesta que nos da. 
![VagrantFile](/img/Docker-img/ejecutar-nginx-autenticacion.png)

### 1.4 Probando la nueva configuración
Como podemos ver al poner la url con el dns falso y el numero de puerto 8080 vemos la pagina perfectamente.
![VagrantFile](/img/Docker-img/probar-nginx-autenticacion.png)

## 2. Tareas
### 2.1. T.1
Ahora solo tenemos que ver la diferencia cuando nos deja entrar con un usuario y contraseña que esta registrado y otro que no. 
![VagrantFile](/img/Docker-img/probar-nginx-autenticacion-usuario.png)

Ahora nos pide que solo salte el inicio de sesión cuando entramos a la seccion de contacto, eso lo tenemos que hacer modificando el archivo `nginx.conf` y la configuración de la siguiente manera: 
![VagrantFile](/img/Docker-img/nginx-conf-autenticacion-usuario.png)

### 2.2. T.2
Tambien lo podemos hacer como indica en el **pdf**,  quitando las dos líneas que tenemos de autorización y creando una nueva para la ruta de contact
![VagrantFile](/img/Docker-img/nginx-conf-autenticacion-contacto.png)

### 2.3. Combinación de la autenticacion básica con la restricción de acceso por IP
Para esta parte tenemos que añadir la sección de código propuesta en el **pdf**, para denegar el acceso a una IP concreta y permitiendo todas las demmás.
![VagrantFile](/img/Docker-img/nginx-conf-autenticacion-ip.png)

Ahora tenemos que combinar la restricción de Up y la autenticación HTTP con la directiva satisfy, donde si le ponemos all, se le permite el acceso al usuario si cumple ambas condiciones, y si le ponemos any, permite el acceso si cumple alguna de las dos condiciones. 
![VagrantFile](/img/Docker-img/nginx-conf-autenticacion-ip-2.png)

## 3. Tareas
### 3.1. T.1
Tenemos que hacer este cambio en la configuración para poder bloquear el acceso al directorio raiz a nuestra IP;
![VagrantFile](/img/Docker-img/bloqueo-ip.png)

Una vez que cambiamos el archivo para denegarle el acceso a nuestra IP del ordenador, nos mostrara el siguiente error:
![VagrantFile](/img/Docker-img/error-nginx-ip.png)

Y el error que nos encontramos en el log es el siguiente: 
![VagrantFile](/img/Docker-img/log-nginx-ip.png)