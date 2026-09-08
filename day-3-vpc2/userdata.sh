#!/bin/bash

apt update -y
apt install nginx -y
echo "<h1> Hello I am Public instance </h1>" > /var/www/html/index.html