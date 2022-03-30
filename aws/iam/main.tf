terraform {
  backend "s3" {
    bucket = "terraform-state-bhuvan"
    key    = "terraform-new.tfstate"
  }
}
resource "aws_iam_group" "developer" {
  name = "developer"
  path = "/users/"
}