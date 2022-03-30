
# module "global_vars"{
#   source = "../global_vars"
# }

resource "aws_instance" "webserver" {
ami = data.aws_ami.ubuntu.id
instance_type = var.instance_type["small"]
  tags = {
    "Name" = var.aws_instance_name
     "Description" = "Webserver"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt-get install nginx -y",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
    ]
    
  }
  key_name = aws_key_pair.web.id
  vpc_security_group_ids = [ aws_security_group.allow_tls.id ]
  connection {
    type = "ssh"
    host = self.public_ip
    user = "ubuntu"
    private_key = tls_private_key.example.private_key_pem
  }
  # user_data = <<-EOF
  #     sudo apt update
  #     sudo apt get nginx
  #     systemctl enable nginx
  #     systemctl start nginx
  #     EOF
  depends_on = [
    aws_security_group.allow_tls,
    tls_private_key.example,
    aws_key_pair.web
  ]
}
