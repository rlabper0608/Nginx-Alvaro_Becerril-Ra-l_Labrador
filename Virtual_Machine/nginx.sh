#!/bin/bash

set -xeu

apt-get update

apt-get install nginx

mkdir -p /var/www/alvaro/html

systemctl status nginx