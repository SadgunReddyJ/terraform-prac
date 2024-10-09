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
    Name = "crm-private-route"
  }
}

#crm web public association 

resource "aws_route_table_association" "crm-web-asc" {
  subnet_id      = aws_subnet.cmr-web-subnet.id
  route_table_id = aws_route_table.crm-public-rt.id
}


#crm  api public association 

resource "aws_route_table_association" "crm-api-asc" {
  subnet_id      = aws_subnet.cmr-api-subnet.id
  route_table_id = aws_route_table.crm-public-rt.id
}


# crm private association 

resource "aws_route_table_association" "crm-db-asc" {
  subnet_id      = aws_subnet.cmr-db-subnet.id
  route_table_id = aws_route_table.crm-private-rt.id
}

# web NACL

resource "aws_network_acl" "crm-web-nacl" {
  vpc_id = aws_vpc.crm-vpc.id

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  tags = {
    Name = "crm-web-nacl"
  }
}

# api NACL

resource "aws_network_acl" "crm-api-nacl" {
  vpc_id = aws_vpc.crm-vpc.id

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  tags = {
    Name = "crm-api-nacl"
  }
}

# DB NACL

resource "aws_network_acl" "crm-db-nacl" {
  vpc_id = aws_vpc.crm-vpc.id

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  tags = {
    Name = "crm-db-nacl"
  }
}

#crm web nacl association

resource "aws_network_acl_association" "crm-web-nacl-asc" {
  network_acl_id = aws_network_acl.crm-web-nacl.id
  subnet_id      = aws_subnet.cmr-web-subnet.id
}

#crm api nacl association

resource "aws_network_acl_association" "crm-api-nacl-asc" {
  network_acl_id = aws_network_acl.crm-api-nacl.id
  subnet_id      = aws_subnet.cmr-api-subnet.id
}

#crm db nacl association

resource "aws_network_acl_association" "crm-db-nacl-asc" {
  network_acl_id = aws_network_acl.crm-db-nacl.id
  subnet_id      = aws_subnet.cmr-db-subnet.id
}

# crm web security group

resource "aws_security_group" "crm-web-sg" {
  name        = "crm-web-sg"
  description = "Allow SSH & HTTP traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "crm-web-sg"
  }
}

# crm web security group ingress 

resource "aws_vpc_security_group_ingress_rule" "crm-web-sg-ingress-ssh" {
  security_group_id = aws_security_group.crm-web-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}


resource "aws_vpc_security_group_ingress_rule" "crm-web-sg-ingress-ssh" {
  security_group_id = aws_security_group.crm-web-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

# crm web security group egress

resource "aws_vpc_security_group_egress_rule" "crm-web-sg-egress" {
  security_group_id = aws_security_group.crm-web-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
