terraform {
  backend "s3" {
    bucket = "terraform-state-bhuvan"
    key    = "terraform_ec2.tfstate"
  }
}

module "aws_instance" {
  source = "../modules/aws_modules/"
}


