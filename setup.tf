# VPC CREATION 

resource "aws_vpc" "ecomm-VPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = "true"

  tags = {
    Name = "ecomm-vpc-related"
  }
}

# PUBLIC SUBNET CREATION

resource "aws_subnet" "ecomm-public-subnet" {
  vpc_id     = aws_vpc.ecomm-VPC.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch ="true"

  tags = {
    Name = "ecomm-public-sn"
  }
}


# PRIVATE SUBNET CREATION 

resource "aws_subnet" "ecomm-private-subnet" {
  vpc_id     = aws_vpc.ecomm-VPC.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch ="false"

  tags = {
    Name = "ecomm-private-sn"
  }
}


# PUBLIC INTERNET GATEWAY 

resource "aws_internet_gateway" "public-ecomm-gateway" {
  vpc_id = aws_vpc.ecomm-VPC.id

  tags = {
    Name = "public-ecomm-gw"
  }
}


# PUBLIC ROUTE TABLE 


resource "aws_route_table" "Ecomm-public-route-table" {
  vpc_id = aws_vpc.ecomm-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public-ecomm-gateway.id
  }


  tags = {
    Name = "ecomm-public-route"
  }
}


# PRIVATE ROUTE TABLE

resource "aws_route_table" "Ecomm-private-route-table" {
  vpc_id = aws_vpc.ecomm-VPC.id

 route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gateway.id
  }


  tags = {
    Name = "ecomm-private-route"
  }
}


# SUBNET ROUTE TABLE ASSOCIATION PUBLIC 

resource "aws_route_table_association" "route-table-assc-pub" {
  subnet_id      = aws_subnet.ecomm-public-subnet.id
  route_table_id = aws_route_table.Ecomm-public-route-table.id
}

# SUBNET ROUTE TABLE ASSOCIATION PRIVATE

resource "aws_route_table_association" "route-table-assc-pri" {
  subnet_id      = aws_subnet.ecomm-private-subnet.id
  route_table_id = aws_route_table.Ecomm-private-route-table.id
}

# ELASTIC IP CREATION 

resource "aws_eip" "ecomm-elastic-ip" {
  vpc      = true

  tags = {
    Name = "ecomm-elastic-ip"
  }
}

# NAT GATEWAY CREATION 


resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.ecomm-elastic-ip.id
  subnet_id     = aws_subnet.ecomm-public-subnet.id

  tags = {
    Name = "ecomm-nat-gateway"
  }

  depends_on = [aws_internet_gateway.public-ecomm-gateway]
}
