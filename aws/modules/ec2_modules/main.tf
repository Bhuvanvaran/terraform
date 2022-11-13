data "aws_ami" "linux" {
  most_recent = true
  owners = [var.aws_data_owner]

  filter {
    name   = "name"
    values = [var.aws_data_osname]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}
resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "web" {
key_name   = var.aws_key_name
public_key = tls_private_key.example.public_key_openssh
}
resource "aws_instance" "webserver" {
ami = data.aws_ami.linux.id
instance_type = var.instance_type["small"]
availability_zone = var.availability_zone
  tags = {
    "Name" = var.aws_instance_name
     "Description" = var.aws_intance_description
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
  
  user_data = <<-EOF
      sudo apt update
       sudo apt get nginx
       systemctl enable nginx
       systemctl start nginx
       EOF
  depends_on = [aws_security_group.allow_tls]
}
resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.test.id
  instance_id = aws_instance.webserver.id
  stop_instance_before_detaching = true
  force_detach = true 
  depends_on = [
    aws_ebs_volume.test
  ]
}

