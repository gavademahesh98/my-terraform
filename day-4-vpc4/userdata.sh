#!/bin/bash

apt update -y
apt install nginx -y
echo "<h1> Hello From $HOSTNAME </h1>" > /var/www/html/index.html