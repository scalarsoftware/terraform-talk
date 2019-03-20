terraform {
  backend "s3" {
    bucket = "terraform-talk-bucket"
    key    = "state"
    region = "us-east-1"
  }
}

provider "aws" {
  access_key = "aws_access_key_id"
  secret_key = "aws_secret_access_key_id"
  region = "us-east-1"
}
