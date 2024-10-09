resource "aws_vpc" "crm-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "crm-vpc"
  }
}
#web subnet
resource "aws_subnet" "cmr-web-subnet" {
  vpc_id     = aws_vpc.crm-vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "cmr-web-subnet"
  }
}
#api subnet
resource "aws_subnet" "cmr-api-subnet" {
  vpc_id     = aws_vpc.crm-vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "cmr-api-subnet"
  }
}
#db subnet
resource "aws_subnet" "cmr-db-subnet" {
  vpc_id     = aws_vpc.crm-vpc.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "cmr-db-subnet"
  }
}
#internet gateway
resource "aws_internet_gateway" "crm-igw" {
  vpc_id = aws_vpc.crm-vpc.id

  tags = {
    Name = "crm-internet-gateway"
  }
}

# crm public route table 

resource "aws_route_table" "crm-public-rt" {
  vpc_id = aws_vpc.crm-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.crm-igw.id
  }

  tags = {
    Name = "crm-public-route"
  }
}

# crm private route table


resource "aws_route_table" "crm-private-rt" {
  vpc_id = aws_vpc.crm-vpc.id

  tags = {
    Name = "crm-pubprivatelic-route"
  }
}