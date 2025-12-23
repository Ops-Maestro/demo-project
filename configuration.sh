#!/bin/bash
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
sudo chown -R www-data:www-data /var/www/html
cd /var/www
sudo rm -rf html/
sudo mkdir html
sudo 