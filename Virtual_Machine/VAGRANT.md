Instalación y provisión de una máquina virtual con servidor:

## · Índice

1. [Instalación servidor Nginx](#1instalación-del-servidor-nginx)
2. [Creación de las carpetas del sitio web](#2creación-de-las-carpetas-del-sitio-web)
3. [Configuración de Servidor NGINX](#3configuración-de-servidor-nginx)
4. [Comprobaciones del servicio NGINX](#4comprobaciones-del-servicio-nginx)
    - [Archivo /etc/hosts](#41-archivo-etchosts)
    - [Utilizando nip.io](#42-utilizando-nipio)
---

### 1.Instalación del servidor Nginx.

Para comenzar, crearemos una máquina virtual con su respectivo VagrantFile y su archivo de provisión, en mi caso,  se llamará nginx.sh :

![VagrantFile](/img/1.VagrantFile.png)

He tenido que cambiar el sistema operativo, ya que esta distribución de Debian, basada en el proyecto Bento, está optimizada para Vagrant.

La anterior presentaba un problema con la interfaz de red, ya que usaba NetworkManager, cuando se requería ifup.

Por tanto, ahora funciona sin problemas.

A continuación, instalamos nginx con los siguientes comandos:

![Nginx.sh](/img/2.Nginx.sh.png)

Primero actualizamos los paquetes y luego, instalamos nginx.Cabe destacar que instalamos también git porque será necesario más adelante.

### 2.Creación de las carpetas del sitio web

Para crear las carpetas de forma automatizada haremos los correspondientes mkdir y cd en nginx.sh :

![Permisos_Nginx.sh](/img/3.Permisos_Carpetas.png)

Primero creamos la carpeta donde se clonará el repositorio indicado en la práctica, luego nos movemos a dicha carpeta y clonamos dicho repositorio.

Por último asignamos que el owner y su grupo sean www-data y que sus permisos, de manera recursiva, para toda la carpeta sean de 755.

### 3.Configuración de Servidor NGINX

Para configurar correctamente el servidor deberemos crear un archivo de configuración, para no modificar el que viene por defecto, y meteremos un 
bloque de servidor con las directivas correctas:

![Configuración Nginx](/img/4.nginx_conf.png)

Debemos de cambiar la directiva root por la ruta absoluta donde estará nuestra página web desplegada, en mi caso, es en la siguiente carpeta:

/var/www/alvaro/html/static-website-example (Que coincide con el lugar donde hicimos el git clone previamente)

Otra directiva que es importante modificar de manera posterior sería el server_name, donde, al no tener servidor DNS, nos servirá para visualizar
la web de nuestro servidor, colocando la ip entre guiones seguida de .alvaro.nip.io

Antes de ponernos con otros comandos, copiaremos este archivo dentro de la máquina virtual con un **cp**, se adjuntará captura más adelante.

Posteriormente, crearemos un **enlace simbolico** entre el archivo de configuración previamente creado junto con la carpeta /sites-enable de nginx,
esto se realizará para que nada más que se encienda la máquina virtual y el servicio nginx, nuestro sitio esté habilitado.

Por último, haremos un reinicio del servicio nginx, y su posterior estado,con el siguiente comando :

```bash
   systemctl restart nginx
   systemctl status nginx
```

Tanto estos tres últimos comandos como la creación del enlace simbólico se realizarán en el archivo nginx.sh:

![Copiado de archivos y systemctl](/img/5.Copiado_archivos.png)


### 4.Comprobaciones del servicio NGINX

#### 4.1 Archivo /etc/hosts

En Windows, seguimos la siguiente ruta desde la terminal (importante,en modo administrador) : C:\Windows\System32\drivers\etc\hosts

En dicho archivo llamado hosts,creamos una linea nueva que tendrá a la izquierda la IP de nuestra máquina virtual y a la derecha nuestro nombre del servidor:

![Archivo /etc/hosts](/img/6.hosts.png)

Ahora introducimos la dirección IP de la MV en nuestro navegador, en mi caso (http://192.168.56.10/), y observamos la página de NGINX por defecto:

![Web por defecto de nginx](/img/7.IP_website.png)

#### 4.2 Utilizando nip.io

Como ya hemos dicho anteriormente, hemos configurado el servername en nuestro archivo de configuración para que tenga nuestra ip entre guiones seguido 
del nombre del servidor y .nip.io;

Ahora, en nuestro navegador, metemos el servername y nos saldrá el index.html del repositorio clonado :

![Web utilizadno nip.io](/img/8.Nip.io.png)






