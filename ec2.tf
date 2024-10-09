resource "aws_instance" "crm-web-server" {
  ami           = "ami-0dee22c13ea7a9a67" # 
  instance_type = "t2.micro"
  subnet_id = aws_subnet.cmr-web-subnet.id
  key_name = "aws_login"
  vpc_security_group_ids = [aws_security_group.crm-web-sg.id]
  user_data = file("setup.sh")
    tags = {
    Name = "crm-web-server"
  }
}