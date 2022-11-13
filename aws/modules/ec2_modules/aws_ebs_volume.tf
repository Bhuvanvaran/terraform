resource "aws_ebs_volume" "test" {
  availability_zone = var.availability_zone
  size              = var.aws_ebs_volume_size
  tags = {
    Name = var.aws_volume_name
  }
}
