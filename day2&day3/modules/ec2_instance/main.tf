resource "aws_instance" "web" {
  ami           = var.ami_value
  instance_type = var.ec2_value
  key_name = "aws_login1"
  subnet_id = "subnet-0fde4dd25d94ae01f"
  associate_public_ip_address = true
  tags = {
    Name = "HelloWorld"
  }
}
