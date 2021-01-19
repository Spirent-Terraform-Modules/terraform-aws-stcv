
provider "aws" {
  region = "us-east-1"
}

module "stcv" {
  source = "../.."

  instance_count = 2

  subnet_id           = "subnet-ffe75cb2"
  test_subnet_ids     = ["subnet-ffe75cb2"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  key_name       = "stcv_dev_key"
  user_data_file = "../../cloud-init.yml"
}

output "public_ip" {
  value = module.stcv.*.public_ip
}

