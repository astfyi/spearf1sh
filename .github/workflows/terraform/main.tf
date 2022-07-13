data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh"

  ingress {
    from_port = "22"
    to_port = "22"
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_instance" "vm" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "c6a.24xlarge"
  availability_zone = "eu-central-1b"
  security_groups = [aws_security_group.allow_ssh.name]

  root_block_device {
    volume_size = 1000
  }

#  connection {
#    host = self.public_ip
#    user = "root"
#    type = "ssh"
#    private_key = file("~/.ssh/id_rsa")
#    timeout = "5m"
#  }
}
