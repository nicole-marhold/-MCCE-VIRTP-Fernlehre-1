#!/bin/bash
sudo yum update -y
sudo yum install mariadb-server -y
sudo systemctl start mariadb
mysql -u root -e "CREATE DATABASE employee"
mysql -u root -e "CREATE TABLE employee.employee (UserId bigint(20) NOT NULL AUTO_INCREMENT,Vorname varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,Nachname varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,Email varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,Telefon varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,PRIMARY KEY (UserId))ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci"
mysql -u root -e "INSERT INTO employee.employee (Vorname, Nachname, Email, Telefon) VALUES('Christoph', 'Marchhart', 'christoph.marchhart@firma.at', '+43664123456')"
mysql -u root -e "INSERT INTO employee.employee (Vorname, Nachname, Email, Telefon) VALUES('Nicole', 'Marhold', 'nicole.marhold@firma.at', '+43676123456')"
sudo yum install git -y
git clone https://github.com/cmarchhart/employee
python3 -m pip install PyMySQL
python3 -m pip install Flask
python3 -m pip install Flask-MySQL
sudo python3 /employee/main.py