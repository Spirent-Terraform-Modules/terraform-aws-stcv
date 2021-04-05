
provider "aws" {
  access_key   = var.aws_access_key
  secret_key   = var.aws_secret_key
  token        = var.aws_session_token
  region       = var.region
}

variable aws_access_key {
  description = "Specifies an AWS access key associated with an IAM user or role."
  type        = string
  default     = ""
}

variable aws_secret_key {
  description = "Specifies the secret key associated with the access key."
  type        = string
  default     = ""
}

variable aws_session_token {
  description = "Temporary session token used to create instances"
  type        = string
  default     = ""
}

variable "region" {
  description = "AWS region"
  default     = "us-west-2"
}

variable "vpc_id" {
  description = "VPC ID"
  default     = "vpc-123456789"
}

variable "mgmt_plane_subnet_id" {
  description = "Management plane subnet ID"
  default     = "subnet-123456789"
}

variable "test_plane_subnet_id" {
  description = "Test plane subnet ID"
  default     = "subnet-123456789"
}

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 2
}

variable "key_name" {
  description = "SSH key name"
  default     = "bootstrap_key"
}

variable "instance_type" {
  description = "AWS instance type"
  default     = "m5.large"
}

module "stcv" {
  source = "../.."

  vpc_id         = var.vpc_id
  instance_count = var.instance_count
  instance_type  = var.instance_type

  mgmt_plane_subnet_id  = var.mgmt_plane_subnet_id
  test_plane_subnet_ids = [var.test_plane_subnet_id]

  # Warning: Using all address cidr block to simplify the example. You should limit instance access.
  ingress_cidr_blocks = ["0.0.0.0/0"]

  key_name       = var.key_name
  user_data_file = "../../cloud-init.yaml"

  root_block_device = [
    {
      volume_type = "standard"
      volume_size = 2
    }
  ]

}

output "instance_public_ips" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = module.stcv.*.instance_public_ips
}
