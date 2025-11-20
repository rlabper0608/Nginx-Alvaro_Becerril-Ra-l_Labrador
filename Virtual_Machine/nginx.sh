#!/bin/bash

set -xeu

apt-get update


apt-get -y install nginx git

mkdir -p /var/www/alvaro/html

cd /var/www/alvaro/html

git clone https://github.com/cloudacademy/static-website-example

chown -R www-data:www-data /var/www/alvaro/html

chmod -R 755 /var/www/alvaro

cp /vagrant/Virtual_Machine/alvaro /etc/nginx/sites-available/alvaro

ln -s /etc/nginx/sites-available/alvaro /etc/nginx/sites-enabled/

systemctl restart nginx
systemctl status nginx