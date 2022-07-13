resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

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
  name = "allow_ssh_spearf1sh"

  ingress {
    from_port        = "22"
    to_port          = "22"
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = "0"
    to_port          = "0"
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_key_pair" "ssh" {
  key_name   = "spearf1sh"
  public_key = tls_private_key.ssh.public_key_openssh
}

resource "aws_instance" "vm" {
  ami               = data.aws_ami.ubuntu.id
  instance_type     = "c6a.24xlarge"
  availability_zone = "eu-central-1b"
  key_name          = aws_key_pair.ssh.key_name
  security_groups   = [aws_security_group.allow_ssh.name]

  root_block_device {
    volume_size = 1000
  }

  connection {
    host        = self.public_ip
    user        = "ubuntu"
    type        = "ssh"
    private_key = tls_private_key.ssh.private_key_openssh
    timeout     = "5m"
  }

  provisioner "remote-exec" {
    inline = [<<EOF
      # Install Docker
      sudo apt-get update && sudo apt-get install -y ca-certificates curl gnupg lsb-release
      sudo mkdir -p /etc/apt/keyrings && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
      echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
      sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

      # Install GitHub CLI
      curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
      sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
      echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
      sudo apt-get update && sudo apt install -y gh

      # Clone spearf1sh repository
      git clone --recurse-submodules https://github.com/advancedsecio/spearf1sh.git

      # Build image
#      sudo docker build -t spearf1sh:latest spearf1sh
#      sudo docker create --name spearf1sh spearf1sh:latest
#      sudo docker cp spearf1sh:/home/buildroot/work/images/sdcard.img sdcard.img

      # Create GitHub release
      GH_TOKEN="${var.gh_token}"
      gh auth login
      touch test.txt
#      gh release create latest sdcard.img
      gh release create latest-test test.txt
    EOF
    ]
  }
}
