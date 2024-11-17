terraform {
  backend "s3" {
    bucket = "sadgun-s3-demo"
    key    = "sadgun/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}
