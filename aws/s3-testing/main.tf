terraform {
  backend "s3" {
    bucket = "terraform-state-bhuvan"
    key    = "terraform.tfstate"
  }
}
resource "aws_s3_bucket" "my_bucket" {
  bucket = "terraform-state-bhuvan"
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
