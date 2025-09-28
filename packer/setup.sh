#!/bin/bash

sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd
sudo mkdir -p /var/www/html
sudo cp -r /tmp/website/* /var/www/html/
