# MCCE-VIRTP-Fernlehre-1 // Infrastructure-as-Code / AWS
from Christoph Marchhart and Nicole Marhold

## General Info
The application consists of three microservices. A web server provides the front end. The back-end consists of two independent machines running a MySQL database and an API for data communication of the web service.

#### Illustration of theSystem architecture:
![grafik](https://user-images.githubusercontent.com/61579665/150420957-767de5b0-d899-4649-812d-e9f0b75e82d9.png)

The web services consist of a staff and inventory service for the purpose of querying staff and IT equipment.
The API provides the GET method for reading records:
- Inventory-Service: http://inventory:80/inventory
- Empoyee-Service: http://employee:80/employee

#### API-Aufruf:
![grafik](https://user-images.githubusercontent.com/61579665/150420849-017aa6f2-e770-4336-bd5a-0bb4e1fd3e66.png)

#### Datenbank-Schema:
![grafik](https://user-images.githubusercontent.com/61579665/150421026-a380eb34-e13d-467c-9a83-d2d3008a9e63.png)

## Prerequisites
- Install Terraform
- Get AWS CLI Credentials from AWS Academy (e.g. in the file ~/.aws/credentials)

## Usage
This command is used to initialize a working directory containing Terraform configuration files. This is the first command that should be run after writing a new Terraform configuration or cloning an existing one from version control:
<copy-button> terraform init </copy-button>

This command creates an execution plan, which lets you preview the changes that Terraform plan to make to your infrastructur:
  terraform plan

This command executes the actions proposed in a Terraform plan.
  terraform apply
  
## Occurred problem
Unfortunately, the output of the web server does not work properly. There is a problem with the JSON decoding, which could not be solved by our side.
