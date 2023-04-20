
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
  count       = length(var.mgmt_plane_security_group_ids) > 0 ? 0 : 1
  name        = "stcv-mgmt-plane-${random_id.uid.id}"
  description = "TestCenter Security Group for management plane traffic"

  vpc_id = var.vpc_id

  # STC chassis
  ingress {
    from_port   = 40004
    to_port     = 40004
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr_blocks
  }

  # STC chassis ready
  ingress {
    from_port   = 40004
    to_port     = 40004
    protocol    = "udp"
    cidr_blocks = var.ingress_cidr_blocks
  }

  # STC chassis (QUIC)
  ingress {
    from_port   = 40005
    to_port     = 40005
    protocol    = "udp"
    cidr_blocks = var.ingress_cidr_blocks
  }

  # STC portgroup
  ingress {
    from_port   = 51204
    to_port     = 51204
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr_blocks
  }

  # STC portgroup (QUIC)
  ingress {
    from_port   = 51204
    to_port     = 51204
    protocol    = "udp"
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

  # STCv to GUI/BLL (QUIC)
  egress {
    from_port   = 49100
    to_port     = 65535
    protocol    = "udp"
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

resource "aws_security_group" "stcv_test_plane" {
  count       = length(var.test_plane_security_group_ids) > 0 ? 0 : 1
  name        = "stcv-test-plane-${random_id.uid.id}"
  description = "TestCenter Security Group for test plane traffic"

  vpc_id = var.vpc_id

  # STC test plane traffic
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "random_id" "uid" {
  byte_length = 8
}

# create STCv
resource "aws_instance" "stcv" {
  count         = var.instance_count
  ami           = var.ami != "" ? var.ami : data.aws_ami.stcv.id
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = data.template_file.user_data.rendered

  dynamic "root_block_device" {
    for_each = length(var.root_block_device) > 0 ? var.root_block_device : [{}]
    content {
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", true)
      encrypted             = lookup(root_block_device.value, "encrypted", null)
      iops                  = lookup(root_block_device.value, "iops", null)
      kms_key_id            = lookup(root_block_device.value, "kms_key_id", null)
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      volume_type           = lookup(root_block_device.value, "volume_type", null)
    }
  }

  network_interface {
    network_interface_id = aws_network_interface.mgmt_plane[count.index].id
    device_index         = 0
  }

  tags = {
    Name = format("%s%d", var.instance_name_prefix, 1 + count.index)
  }
}

locals {
  test_plane_subnet_count = length(var.test_plane_subnet_ids)
}

resource "aws_network_interface" "mgmt_plane" {
  count           = var.instance_count
  subnet_id       = var.mgmt_plane_subnet_id
  security_groups = length(var.mgmt_plane_security_group_ids) > 0 ? var.mgmt_plane_security_group_ids : [aws_security_group.stcv_mgmt_plane[0].id]
}

resource "aws_eip_association" "mgmt_plane" {
  count                = length(var.mgmt_plane_eips)
  network_interface_id = aws_network_interface.mgmt_plane[count.index].id
  allocation_id        = var.mgmt_plane_eips[count.index]
}

# Create test network interfaces for each instance
# Each instance will transmit and receive traffic on each test network
resource "aws_network_interface" "test_plane" {
  count           = var.instance_count * local.test_plane_subnet_count
  subnet_id       = var.test_plane_subnet_ids[floor(count.index / var.instance_count)]
  security_groups = length(var.test_plane_security_group_ids) > 0 ? var.test_plane_security_group_ids : [aws_security_group.stcv_test_plane[0].id]

  attachment {
    instance     = aws_instance.stcv[count.index % var.instance_count].id
    device_index = 1 + floor(count.index / var.instance_count)
  }
}
