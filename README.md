# MCCE-VIRTP-Fernlehre-1 // Infrastructure-as-Code / AWS
## Christoph Marchhart und Nicole Marhold

Die Applikation besteht aus drei Microservices. Ein Webserver stellt dabei das Front-End zur Verfügung. Das Back-End besteht aus zwei unabhängigen Maschinen, auf denen eine MySQLDatenbank läuft, sowie eine API zur Datenkommunikation des Webservices dient.

### System-Architektur
![grafik](https://user-images.githubusercontent.com/61579665/150420957-767de5b0-d899-4649-812d-e9f0b75e82d9.png)

Bei den Webservices handelt es sich um ein Mitarbeiter- und Inventar-Service zum Zweck einer Abfrage von Mitarbeitern und IT-Equipment.
Die API stellt die GET-Methode zum Auslesen von Datensätzen zur Verfügung:
Inventory-Service: http://inventory:80/inventory
Empoyee-Service: http://employee:80/employee

### API-Aufruf
![grafik](https://user-images.githubusercontent.com/61579665/150420849-017aa6f2-e770-4336-bd5a-0bb4e1fd3e66.png)

### Datenbank-Schema
![grafik](https://user-images.githubusercontent.com/61579665/150421026-a380eb34-e13d-467c-9a83-d2d3008a9e63.png)
