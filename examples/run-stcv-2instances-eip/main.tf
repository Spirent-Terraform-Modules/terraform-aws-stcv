provider "aws" {
  region = "us-west-2"
}

data "aws_vpc" "default" {
  tags = {
    ExampleName = "vpc1"
  }
}

data "aws_subnet" "mgmt_plane" {
  vpc_id = data.aws_vpc.default.id
  tags = {
    ExampleName = "mgmt_plane"
  }
}

data "aws_subnet" "test_plane1" {
  vpc_id = data.aws_vpc.default.id
  tags = {
    ExampleName = "test_plane1"
  }
}

data "aws_eip" "eip1" {
  tags = {
    ExampleName = "eip1"
  }
}

data "aws_eip" "eip2" {
  tags = {
    ExampleName = "eip2"
  }
}


variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 2
}

# Example: Allocate elastic IPs
# resource "aws_eip" "stcv" {
#  count =  var.instance_count
#  vpc      = true
# }

module "stcv" {
  source            = "../.."
  vpc_id            = data.aws_vpc.default.id
  instance_count    = 2
  mgmt_plane_subnet = data.aws_subnet.mgmt_plane.id
  mgmt_plane_eips   = [data.aws_eip.eip1.id, data.aws_eip.eip2.id]
  # mgmt_plane_eips = aws_eip.stcv.*.id
  test_plane_subnets = [data.aws_subnet.test_plane1.id]
  # Warning: Using all adddress cidr block to simplify the example. You should limit instance access.
  ingress_cidr_blocks = ["0.0.0.0/0"]
  key_name            = "spirent_ec2"
  user_data_file      = "../../cloud-init.yaml"
}

output "instance_public_ips" {
  value = module.stcv.instance_public_ips
}
