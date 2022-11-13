variable "availability_zone" {
  type = string
  default = "ap-south-1a"
}
variable "aws_ebs_volume_size" {
  type = number
  default = 8
}

variable "instance_type"{
    type = map
    default = {
        small = "t2.micro"
    }
}
variable "aws_key_name" {
  type = string
  default = "Mytestserver-Key"
}

variable "aws_security_group_name" {
  type = string
  default = "golbal-security-group-key"
}
variable "aws_security_group_to_port" {
  type = number
  default = 22
}
variable "aws_instance_name" {
  type = string
  default = "My-server-key"
}
variable "aws_s3_db_bucketname" {
  type = string
  default = "terraform-state-bhuvan"
}
variable "aws_s3_db_keyname" {
  type = string
  default = "terraform_ec2.tfstate"
}
variable "aws_intance_description" {
  type = string
  default = "Webserver"
}
variable "aws_securitygroup_description" {
  type = string
  default = "Webserver-security group"
}
variable "aws_volume_name" {
  type = string
  default = "Webserver-security group"
}

variable "aws_data_osname" {
  type = string
  default = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
}
variable "aws_data_owner" {
  type = string
  default = "099720109477"
}


