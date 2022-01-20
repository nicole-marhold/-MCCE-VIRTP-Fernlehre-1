#!/bin/bash
sudo yum update -y
sudo yum install httpd -y
sudo systemctl start httpd
sudo yum install git -y
git clone https://github.com/cmarchhart/webserver
sudo mv /webserver/* /var/www/html/
cp /etc/hosts /tmp
sudo echo "${api_inventory} inventory" >> /tmp/hosts
sudo echo "${api_employee} employee" >> /tmp/hosts
sudo mv /tmp/hosts /etc/