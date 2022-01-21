# MCCE-VIRTP-Fernlehre-1 // Infrastructure-as-Code / AWS
from Christoph Marchhart and Nicole Marhold

## General Info
The application consists of three microservices. A web server provides the front end. The back-end consists of two independent machines running a MySQL database and an API for data communication of the web service.

##### System architecture
![grafik](https://user-images.githubusercontent.com/61579665/150420957-767de5b0-d899-4649-812d-e9f0b75e82d9.png)

The web services consist of a staff and inventory service for the purpose of querying staff and IT equipment.
The API provides the GET method for reading records:
- Inventory-Service: http://inventory:80/inventory
- Empoyee-Service: http://employee:80/employee

##### API-Aufruf
![grafik](https://user-images.githubusercontent.com/61579665/150420849-017aa6f2-e770-4336-bd5a-0bb4e1fd3e66.png)

##### Datenbank-Schema
![grafik](https://user-images.githubusercontent.com/61579665/150421026-a380eb34-e13d-467c-9a83-d2d3008a9e63.png)

## Occurred problem
Unfortunately, the output of the web server does not work properly. There is a problem with the JSON decoding, which could not be solved by our side.
