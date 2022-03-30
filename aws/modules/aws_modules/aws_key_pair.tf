# module "global_vars"{
#   source = "../global_vars"
# }
resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "web" {
key_name   = var.aws_key_name
public_key = tls_private_key.example.public_key_openssh
}