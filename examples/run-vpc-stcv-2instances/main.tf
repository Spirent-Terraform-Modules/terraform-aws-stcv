provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "temp-stcv"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}

module "stcv" {
  source = "../.."

  instance_count = 2

  vpc_id             = module.vpc.vpc_id
  mgmt_plane_subnet  = module.vpc.public_subnets[0]
  test_plane_subnets = module.vpc.private_subnets

  # Warning: Using all address cidr block to simplify the example. You should limit instance access.
  ingress_cidr_blocks = ["0.0.0.0/0"]

  key_name       = "stcv_dev_key"
  user_data_file = "../../cloud-init.yaml"
}

output "instance_public_ip" {
  value = module.stcv.*.instance_public_ips
}

