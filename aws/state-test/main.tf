terraform {
  backend "s3" {
    bucket = "new-bucket-today"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "new-bucket-today"
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}