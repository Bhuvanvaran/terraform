terraform {
  backend "s3" {
    bucket = "terraform-state-bhuvan"
    key    = "my.tfstate"
  }
}
module "ec2_modules" {
  source = "../modules/ec2_modules"
  aws_instance_name = "webservers-stage"
  aws_s3_db_bucketname = "terraform-state-bhuvan"
  aws_s3_db_keyname = "mystaatdde.tfstate"
  aws_key_name = "webservers-stage-key"
  availability_zone = "ap-south-1a"
  aws_ebs_volume_size = 30
}