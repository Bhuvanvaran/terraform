# module "global_vars"{
#   source = "../global_vars"
# }

resource "aws_ebs_volume" "test" {
  availability_zone = var.availability_zone
  size              = var.aws_ebs_volume_size
  tags = {
    Name = "HelloWorld"
  }
}
