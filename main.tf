data "aws_ami" "amazon-2" {
  most_recent = true

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
  owners = ["amazon"]
}

# Resource for webserver
resource "aws_instance" "webserver" {
  ami = data.aws_ami.amazon-2.id
  instance_type = "t3.micro"
  subnet_id = aws_subnet.public-subnet.id

  user_data = templatefile("${path.module}/templates/init_webserver.tpl", { api_inventory = aws_instance.inventory.private_ip, api_employee = aws_instance.employee.private_ip})

  vpc_security_group_ids = [aws_security_group.ingress-all-ssh.id, aws_security_group.ingress-all-http.id]

  tags = {
    Name = "webserver"
  }
}

# Resource for inventory service
resource "aws_instance" "inventory" {
  ami = data.aws_ami.amazon-2.id
  instance_type = "t3.micro"
  #subnet_id = aws_subnet.private-subnet.id
  subnet_id = aws_subnet.public-subnet.id
  
  user_data = templatefile("${path.module}/templates/init_inventory.tpl", { })

  vpc_security_group_ids = [aws_security_group.ingress-all-ssh.id, aws_security_group.ingress-all-http.id]

  tags = {
    Name = "inventory"
  }
}

# Resource for employee service
resource "aws_instance" "employee" {
  ami = data.aws_ami.amazon-2.id
  instance_type = "t3.micro"
  #subnet_id = aws_subnet.private-subnet.id
  subnet_id = aws_subnet.public-subnet.id
 
  user_data = templatefile("${path.module}/templates/init_employee.tpl", { })

  vpc_security_group_ids = [aws_security_group.ingress-all-ssh.id, aws_security_group.ingress-all-http.id]

  tags = {
    Name = "employee"
  }
}


resource "aws_security_group" "ingress-all-ssh" {
  name = "allow-all-ssh"
  vpc_id      = aws_vpc.main.id
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
  // Terraform removes the default rule
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "ingress-all-http" {
  name = "allow-all-http"
  vpc_id      = aws_vpc.main.id
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 80
    to_port = 80
    protocol = "tcp"
  }
  // Terraform removes the default rule
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/27"
}

resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.0/28"
  map_public_ip_on_launch = "true"


  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "private-subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.16/28"
  map_public_ip_on_launch = "false"


  tags = {
    Name = "private-subnet"
  }
}

resource "aws_internet_gateway" "internet-gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "internet-gw"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gw.id
  }
}

resource "aws_route_table_association" "public-rta" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-subnet.id
  depends_on    = [aws_internet_gateway.internet-gw]
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }
}

resource "aws_route_table_association" "private-rta" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private-rt.id
}
