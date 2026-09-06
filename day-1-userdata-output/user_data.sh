#!/bin/bash
apt update -y
apt install nginx -y
echo "<h1>Welcome to my first terraform EC2 instance</h1>" > /var/www/html/index.html