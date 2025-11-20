Instalación y provisión de una máquina virtual con servidor:

## · Índice

1. [Instalación servidor Nginx](#instalación)
2. [Comandos utilizados](#comandos-utilizados-en-el-proyecto)
   - [Comandos de Vagrant (Terminal local)](#comandos-de-vagrant-terminal-local)
   - [Comandos de Linux (Terminal remota)](#comandos-de-linux-terminal-remota)
   - [Comandos para verificación](#comandos-para-verificación)
3. [Ejecución del proyecto](#ejecución-del-proyecto)

---

### Instalación del servidor Nginx.

Para comenzar, crearemos una máquina virtual con su respectivo VagrantFile y su archivo de provisión, en mi caso,  se llamará nginx.sh :

![VagrantFile](img/1.VagrantFile.png)

He tenido que cambiar el sistema operativo, ya que esta distribución de Debian, basada en el proyecto Bento, está optimizada para Vagrant.

La anterior presentaba un problema con la interfaz de red, ya que usaba NetworkManager, cuando se requería ifup.

Por tanto, ahora funciona sin problemas.

A continuación, instalamos nginx con los siguientes comandos:

![Nginx.sh](img/2.Nginxsh.png)

Primero actualizamos los paquetes y luego, instalamos nginx.Cabe destacar que instalamos también git porque será necesario más adelante.

### Creación de las carpetas del sitio web

Para crear las carpetas de forma automatizada haremos los correspondientes mkdir y cd en nginx.sh :

![Permisos_Nginx.sh](img/3.Permisos_Carpetas.png)

Primero creamos la carpeta donde se clonará el repositorio indicado en la práctica, luego nos movemos a dicha carpeta y clonamos dicho repositorio.

Por último asignamos que el owner y su grupo sean www-data y que sus permisos, de manera recursiva, para toda la carpeta sean de 755.

### Creación de las carpetas del sitio web

