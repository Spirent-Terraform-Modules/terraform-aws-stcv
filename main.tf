
# find latest public Spirent TestCenter Virtual AMI
data "aws_ami" "stcv" {
  owners           = ["679593333241"]
  most_recent      = true
  executable_users = ["all"]

  filter {
    name   = "name"
    values = ["STCv-*"]
  }
}

data "template_file" "user_data" {
  template = file(var.user_data_file)
}

resource "aws_security_group" "stcv_mgmt_plane" {
  name        = "stcv-mgmt-plane"
  description = "TestCenter Security Group"

  vpc_id = var.vpc_id

  # STC app
  ingress {
    from_port   = 40004
    to_port     = 40004
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr_blocks
  }

  # STC app
  ingress {
    from_port   = 51204
    to_port     = 51204
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr_blocks
  }

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr_blocks
  }

  # STCv to GUI/BLL
  egress {
    from_port   = 49100
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # STCv to NTP server
  egress {
    from_port   = 123
    to_port     = 123
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

# create STCv
resource "aws_instance" "stcv" {
  count         = var.instance_count
  ami           = var.ami != "" ? var.ami : data.aws_ami.stcv.id
  instance_type = var.instance_type
  subnet_id     = var.mgmt_plane_subnet
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.stcv_mgmt_plane.id]
  user_data              = data.template_file.user_data.rendered

  tags = {
    Name = format("%s%d", var.instance_name_prefix, 1 + count.index)
  }
}

locals {
  test_plane_subnet_count = length(var.test_plane_subnets)
}


# Create test network interfaces for each instance
# Each instance will transmit and receive traffic on each test network
resource "aws_network_interface" "test_plane" {
  count     = var.instance_count * local.test_plane_subnet_count
  subnet_id = var.test_plane_subnets[floor(count.index / var.instance_count)]
  attachment {
    instance     = aws_instance.stcv[count.index % var.instance_count].id
    device_index = 1 + floor(count.index / var.instance_count)
  }
}
