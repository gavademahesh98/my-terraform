#!/bin/bash

apt update -y
apt install nginx -y
echo "<h1> Welcome to My instance</h1>" > /var/www/html/index.html
