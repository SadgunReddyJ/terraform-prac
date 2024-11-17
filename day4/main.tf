provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "sadgun" {
  instance_type = "t2.micro"
  ami = "ami-0866a3c8686eaeeba"
  associate_public_ip_address = true
  subnet_id = "subnet-0fde4dd25d94ae01f"
}
resource "aws_s3_bucket" "sadgun_s3" {
  bucket = "sadgun-s3-demo"
}


resource "aws_dynamodb_table" "terraform_lock" {
  name           = "terraform-lock"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}