provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "default" {
  default = true
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
  mgmt_plane_subnet = "subnet-052d25f376ad3b040"
  mgmt_plane_eips   = ["eipalloc-0617e4c567e3eaef7", "eipalloc-062e18b27b47d6fca"]
  # mgmt_plane_eips = aws_eip.stcv.*.id
  test_plane_subnets = ["subnet-0f845bf3bd4d6e258"]
  # Warning: Using all adddress cidr block to simplify the example. You should limit instance access.
  ingress_cidr_blocks = ["0.0.0.0/0"]
  key_name            = "spirent_ec2"
  user_data_file      = "../../cloud-init.yaml"
}

output "instance_public_ips" {
  value = module.stcv.instance_public_ips
}
