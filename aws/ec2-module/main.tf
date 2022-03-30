terraform {
  backend "s3" {
    bucket = "terraform-state-bhuvan"
    key    = "terraform_ec2.tfstate"
  }
}

module "aws_ebs_volume"{
  source = "../modules/aws_modules/"
  //availability_zone = "ap-south-1a"
  //aws_ebs_volume_size = 8
}

module "aws_instance" {
  source = "../modules/aws_modules/"
  //aws_instance_name = "mytestservernew"
}

module "aws_key_pair" {
  source = "../modules/aws_modules/"
  //aws_key_name = "My-Testserver-keya"
}
module "tls_private_key" {
  source = "../modules/aws_modules/" 
}
module "aws_security_group" {
  source = "../modules/aws_modules/"
  //aws_security_group_name = "my-golbal-security-group"
  //aws_security_group_to_port = 22
}


