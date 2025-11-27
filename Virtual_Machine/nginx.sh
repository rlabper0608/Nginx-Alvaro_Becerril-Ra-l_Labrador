#!/bin/bash

set -xeu

apt-get update


apt-get -y install nginx git openssl

sh -c "echo -n 'alvaro:' >> /etc/nginx/.htpasswd"
sh -c "openssl passwd -apr1 'alvaropass'>> /etc/nginx/.htpasswd"

sh -c "echo -n 'robles:' >> /etc/nginx/.htpasswd"
sh -c "openssl passwd -apr1 'roblespass'>> /etc/nginx/.htpasswd"  

mkdir -p /var/www/alvaro/html

cd /var/www/alvaro/html

git clone https://github.com/cloudacademy/static-website-example

chown -R www-data:www-data /var/www/alvaro/html

chmod -R 755 /var/www/alvaro

cp /vagrant/alvaro /etc/nginx/sites-available/alvaro

ln -s /etc/nginx/sites-available/alvaro /etc/nginx/sites-enabled/
 

systemctl restart nginx
systemctl status nginx