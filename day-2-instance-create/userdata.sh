#!/bin/bash

apt update -y
apt install apache2 -y
echo "<h1>Welcome to my first terraform created instance</h1>" > /var/www/html/index.html