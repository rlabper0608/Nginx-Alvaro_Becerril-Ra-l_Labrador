#!/bin/bash

set -xeu

apt-get update

apt-get -y install nginx

mkdir -p /var/www/alvaro/html

systemctl status nginx