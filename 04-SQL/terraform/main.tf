provider "aws" {
  region = "sa-east-1"
}

# Stage

resource "aws_instance" "mysql_instance-stag" {
  subnet_id = "${var.subnetPrivada}"
  ami = "${var.amiId}"
  instance_type = "t2.large"
  key_name = "${var.keyPrivate}"
  root_block_device {
    encrypted = true
    volume_size = 20
  }
  tags = {
    Name = "mysql-stag2"
  }
  vpc_security_group_ids = [aws_security_group.mysql-sgStag.id]
}

resource "aws_security_group" "mysql-sgStag" {
  name        = "mysql-sgStag2"
  description = "acessos inbound traffic"
  vpc_id      = "${var.vpcId}"
  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids = null,
      security_groups: null,
      self: null
    },
    {
      description      = "mysql"
      from_port        = 3306
      to_port          = 3306
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids = null,
      security_groups: null,
      self: null
    }
  ]
  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = [],
      prefix_list_ids = null,
      security_groups: null,
      self: null,
      description: "Libera dados da rede interna"
    }
  ]
  tags = {
    Name = "mysql-sgStag2"
  }
}

# Variaveis

variable "vpcId" {
  type        = string
}

variable "amiId" {
  type        = string
  default = "
}

variable "subnetPrivada" {
  type        = string
}

variable "keyPrivate" {
  type        = string
}

# Outputs

output "output-mysql-stag" {
  value = ["mysql_instance_stag ${aws_instance.mysql_instance-stag.private_ip}"]
}
