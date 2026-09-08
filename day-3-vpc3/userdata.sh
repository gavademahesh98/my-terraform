#!/bin/bash

apt update -y 
apt install nginx -y
echo "<h1> Hello from Public Instance</h1>" > /var/www/html/index.html