resource "aws_instance" "web" {
  ami           = "ami-0866a3c8686eaeeba"
  instance_type = "t2.micro"
  key_name = "aws_login1"
  subnet_id = "subnet-0fde4dd25d94ae01f"
  associate_public_ip_address = true
  tags = {
    Name = "HelloWorld"
  }
}