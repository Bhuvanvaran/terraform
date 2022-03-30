data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

terraform {
  backend "s3" {
    bucket = "terraform-state-bhuvan"
    key    = "terraform_ec2.tfstate"
  }
}
resource "aws_ebs_volume" "test" {
  availability_zone = "ap-south-1a"
  size              = 8
  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_instance" "webserver" {
ami = data.aws_ami.ubuntu.id
instance_type = var.instance_type["small"]
  tags = {
    "Name" = "Webserver"
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
}
resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.test.id
  instance_id = aws_instance.webserver.id
  stop_instance_before_detaching = true
  force_detach = true 
}
resource "aws_key_pair" "web" {
key_name   = "ubuntu-key"
public_key = tls_private_key.example.public_key_openssh
}

#This resource block is to create keypair -- General
resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  #vpc_id      = aws_vpc.main.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
