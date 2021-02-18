
Run 2 Spirent TestCenter Virtual traffic generator instances with public and test networks using elastic IPs.

Instances can be controlled by the [Spirent TestCenter application](https://github.com/Spirent-terraform-Modules/terraform-aws-stc-gui).

## Usage

To run this example you need to execute:

    $ terraform init
    $ terraform plan
    $ terraform apply

This example will create resources that will incur a cost. Run `terraform destroy` when you don't need these resources.

Usage of Spirent TestCenter Virtual instances follows a Bring-Your-Own-License (BYOL) approach and is available for customers with current licenses purchased via [Spirent support](https://support.spirent.com/SpirentCSC).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| aws | >= 2.65 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| eip\_id1 | Instance 1 Elastic IP ID | `string` | `"eipalloc-123456789"` | no |
| eip\_id2 | Instance 2 Elastic IP ID | `string` | `"eipalloc-123456789"` | no |
| instance\_count | Number of instances to create | `number` | `2` | no |
| key\_name | SSH key name | `string` | `"bootstrap_key"` | no |
| mgmt\_plane\_subnet\_id | Management plane subnet ID | `string` | `"subnet-123456789"` | no |
| region | AWS region | `string` | `"us-west-2"` | no |
| test\_plane\_subnet\_id | Test plane subnet ID | `string` | `"subnet-123456789"` | no |
| vpc\_id | VPC ID | `string` | `"vpc-123456789"` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance\_public\_ips | List of public IP addresses assigned to the instances, if applicable |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

