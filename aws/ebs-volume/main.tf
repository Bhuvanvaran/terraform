resource "aws_ebs_volume" "test" {
  availability_zone = "ap-south-1"
  size              = 40

  tags = {
    Name = "HelloWorld"
  }
}