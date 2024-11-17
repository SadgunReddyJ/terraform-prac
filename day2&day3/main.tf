provider "aws" {
  region = us-east-1
}
module "ec2" {
  source = "./modules/ec2_instance"
  ami_value = "ami-0866a3c8686eaeeba"
  ec2_value = "t2.micro"
}