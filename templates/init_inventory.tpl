#!/bin/bash
sudo yum update -y
sudo yum install mariadb-server -y
sudo systemctl start mariadb
mysql -u root -e "CREATE DATABASE inventory"
mysql -u root -e "CREATE TABLE inventory.inventory (Id bigint(20) NOT NULL AUTO_INCREMENT,Typ varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,Hersteller varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,Model varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,Seriennummer varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,UserId varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,PRIMARY KEY (Id))ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci"
mysql -u root -e "INSERT INTO inventory.inventory (Typ, Hersteller, Model, Seriennummer, UserId) VALUES('PC', 'HP', 'EliteDesk 800 G3 SFF', 'CXU01825W', '1')"
mysql -u root -e "INSERT INTO inventory.inventory (Typ, Hersteller, Model, Seriennummer, UserId) VALUES('Laptop', 'HP', 'EliteBook x360 1040 G7', 'SUL13841A', '2')"
sudo yum install git -y
git clone https://github.com/cmarchhart/inventory
python3 -m pip install PyMySQL
python3 -m pip install Flask
python3 -m pip install Flask-MySQL
sudo python3 /inventory/main.py
