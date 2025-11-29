#!/bin/bash

set -xeu

apt-get update


apt-get -y install nginx git openssl ufw

ufw --force enable

ufw allow ssh
ufw allow 'Nginx Full'
ufw delete allow 'Nginx HTTP'

ufw status

openssl req -x509 -nodes -days 365 \ 
  -newkey rsa:2048 -keyout /etc/ssl/private/192-168-56-10.alvaro.nip.io.key \ 
  -out /etc/ssl/certs/192-168-56-10.alvaro.nip.io.crt
  -subj "/C=ES/ST=Granada/L=Granada/O=MiEmpresa/OU=IT/CN=192-168-56-10.alvaro.nip.io"


sh -c "echo -n 'alvaro:' >> /etc/nginx/.htpasswd"
sh -c "openssl passwd -apr1 'alvaropass'>> /etc/nginx/.htpasswd"

sh -c "echo -n 'robles:' >> /etc/nginx/.htpasswd"
sh -c "openssl passwd -apr1 'roblespass'>> /etc/nginx/.htpasswd"  

mkdir -p /var/www/alvaro/html

cd /var/www/alvaro/html


chown -R www-data:www-data /var/www/alvaro/html

chmod -R 755 /var/www/alvaro

cp /vagrant/alvaro /etc/nginx/sites-available/alvaro

ln -sf /etc/nginx/sites-available/alvaro /etc/nginx/sites-enabled/
 

systemctl restart nginx
systemctl status nginx