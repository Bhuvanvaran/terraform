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


