Esta parte de la práctica la ha realizado Álvaro Becerril Robles, obviamente Raúl Labrador también ha participado y observado el proceso, pero lo que es realizar la escritura de los comandos, la configuración y este Readme ha sido realizado por Álvaro.
## Índice

1. [Instalación servidor Nginx](#1-instalación-del-servidor-nginx)
2. [Creación de las carpetas del sitio web](#2-creación-de-las-carpetas-del-sitio-web)
3. [Configuración de Servidor NGINX](#3-configuración-de-servidor-nginx)
4. [Comprobaciones del servicio NGINX](#4-comprobaciones-del-servicio-nginx)
   - [Archivo /etc/hosts](#41-archivo-etchosts)
   - [Utilizando nip.io](#42-utilizando-nipio)
5. [Autenticación en Nginx](#5-autenticación-en-nginx)
   - [Instalación de openssl](#51-instalación-de-openssl)
   - [Creación de usuarios y contraseñas](#52-creación-de-usuarios-y-contraseñas)
   - [Configuración del sitio web](#53-configuración-del-sitio-web)
   - [Comprobación de autenticación](#54-comprobación-de-autenticación)
   - [Tareas](#55-tareas)
     - [Tarea 1 – Logs de autenticación](#tarea-1)
     - [Tarea 2 – Autenticación en contacthtml](#tarea-2)
     - [Tarea 3 – Bloqueo por IP de la máquina anfitriona](#tarea-3)
     - [Tarea 4 – Requerir IP válida y usuario/contraseña](#tarea-4)


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

![Configuración Nginx](/img/4.Nginx_conf.png)

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

### 5.Autenticación en Nginx

Para comenzar con la autenticación, primero deberemos instalar el paquete openssl

En nginx.sh agregamos a esta linea la setencia "openssl":

```bash
   apt-get -y install nginx git openssl
```

### 5.2 Creación de usuarios y contraseñas

Agregaremos a nginx.sh las siguientes sentencias :

![Usuarios y Contraseñas](/img/9.usuarios.png)

Con la primera sentencia estamos creando un usuario, donde 'alvaro' es dicho nombre de usuario.
En la segunda sentencia le asignamos una contraseña, en mi caso, 'alvaropass'

He creado 2 usuarios con su respectiva contraseña, toda esta información se almacena en un archivo oculto llamado 
.htpasswd. Dicho archivo se creará automaticamente con la redirección ">>"

Comprobamos que se han creado correctamente haciendo un cat a dicho archivo:

![Lista usuarios](/img/10.Listado_usuarios.png)

### 5.3 Configuración de sitio web

Para desplegar el sitio web en mi servidor Nginx he seguido los siguientes pasos:

1. Descomprimir el zip en mi máquina anfitriona y subir la carpeta html al proyecto

2. Crear un enlace blando desde la configuración de Vagrant hacia la carpeta /var/www/alvaro/html :

![Sincronizar carpetas](/img/11.sync_folder.png)

Así las dos carpetas quedan sincronizadas, es decir, apuntan al mismo contenido, que en mi caso es la página web completa, incluyendo css, js e imágenes.

3. Modificiar la configuración de Nginx :

Editaremos el archivo de configuración llamado alvaro de la siguiente manera:

![Despliegue web](/img/12.despliegue_web.png)

Simplemente hemos cambiado a donde apunta root, modificandolo en base a nuestra carpeta html

OJO: ponemos sendfile off; ya que el mapeo de archivos nos corrompe algunas hojas de estilo o mismamente el jquery.

En location estamos solicitando autenticación de usuario en la raíz ( / ), en la cual usaremos como referencia el archivo creado previamente .htpasswd

### 5.4 Comprobación de autentificación

Una vez accedamos desde el navegador, nos aparecerá lo siguiente:

![Login](/img/13.Intento_Login.png)

Al acceder a la página nos la cargará sin problemas:

![WebPage](/img/14.website.png)

Si rechazamos la autentificación, nos saltará el siguiente error 401:

![Cancelar Login](/img/15.Cancelar_Login.png)

### 5.5 Tareas

#### Tarea 1

Obtendremos el acceso a los logs, concretamente y en esta ocasión, en access.log.

![User Logs](/img/16.Nginx_logs.png)

En la primera linea vemos un Login correcto, dando como respuesta del servidor **200**.En la segunda rechazé el login, con lo que responde con error 401 con el usuario "-".

En la tercera linea me inventé un usuario "robles2" y como podemos observar almacena el nombre de dicho usuario pero rechaza la conexión con el error 401.

#### Tarea 2

Para realizar una autenticación exclusivamente en contact.html, crearemos otra sección de location en la configuración de la siguiente manera:

![Web Contact](/img/17.contact.html.png)

Es muy similar a la location de la raíz, salvo que donde pone / colocamos contact.html (que es el archivo que queremos), el mensaje de autenticación es el mismo y el fichero dejamos el que hemos añadido previamente.

Ahora cuando nos metamos a Contact nos pedirá la autenticación :

![Contact Authe](/img/18.Contact_authentification.png)

#### Tarea 3

Para que no nos deje acceder con la Ip de la máquina anfitriona, primero deberemos saber la IP de esta misma.

Para ello, yo que estoy en Windows, abrimos una nueva terminal (cmd) y colocaremos el comando **ipconfig**,
el cuál nos dará la siguiente salida :

![ipconfig](/img/20.ipconfig.png)

Ahora dicha IPV4 la pondremos en la configuración de location con la directiva **deny** :

![deny](/img/19.Bloqueo_IP.png)

El navegador nos dará el siguiente error :

![forbidden](/img/21.Forbidden.png)

y en el error.log de Nginx nos dará lo siguiente :

![errorLogs](/img/22.Error_Bloqueo_IP.png)

#### Tarea 4

Para que requiera autenticar la IP y el tandem usuario/contraseña usarmeos la directiva **satisfy all**, luego con **allow** permitiremos las conexiones desde nuestra IP, quedando así la configuración de Nginx:

![Configuración en nginx para el doble requisito](/img/23.Doble_Requisito_conf.png)

y en el navegador nos saldrá nuevamente la autenticación:

![Intento de Login con Doble Requisito](/img/23.Doble_Requisito_conf.png)






















