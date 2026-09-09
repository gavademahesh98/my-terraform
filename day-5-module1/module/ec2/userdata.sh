#!/bin/bash

apt update -y
apt install nginx -y
systemctl start nginx
systemctl enable nginx 
echo "<h1> Hello From $HOSTNAME</h1>" > /var/www/html/index.html
