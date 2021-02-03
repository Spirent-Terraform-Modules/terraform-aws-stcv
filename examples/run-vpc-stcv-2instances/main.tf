provider "aws" {
  region = var.region
}

variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "azs" {
  description = "AWS availability zone list"
  default     = ["us-east-1a"]
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "temp-stcv"
  cidr = "10.0.0.0/16"

  azs             = var.azs
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}

variable "key_name" {
  description = "SSH key name"
  default     = "bootstrap_key"
}

module "stcv" {
  source = "../.."

  instance_count = 2

  vpc_id                = module.vpc.vpc_id
  mgmt_plane_subnet_id  = module.vpc.public_subnets[0]
  test_plane_subnet_ids = module.vpc.private_subnets

  # Warning: Using all address cidr block to simplify the example. You should limit instance access.
  ingress_cidr_blocks = ["0.0.0.0/0"]

  key_name       = var.key_name
  user_data_file = "../../cloud-init.yaml"
}

output "instance_public_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = module.stcv.*.instance_public_ips
}
