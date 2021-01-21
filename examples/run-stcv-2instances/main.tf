
provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "default" {
  default = true
}

module "stcv" {
  source = "../.."

  vpc_id         = data.aws_vpc.default.id
  instance_count = 2

  mgmt_plane_subnet   = "subnet-ffe75cb2"
  test_plane_subnets  = ["subnet-08766a2cc62ba63bc"]
  # Warning: Using all adddress cidr block to simplify the example. You should restrict addresses to your public network.
  ingress_cidr_blocks = ["0.0.0.0/0"]

  key_name       = "stcv_dev_key"
  user_data_file = "../../cloud-init.yml"
}

output "public_ip" {
  value = module.stcv.*.public_ip
}

