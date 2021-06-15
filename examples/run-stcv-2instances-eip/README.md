
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

## Modules

| Name | Source | Version |
|------|--------|---------|
| stcv | ../.. |  |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami | The Spirent TestCenter Virtual AMI. When not specified, the latest marketplace image will be used. | `string` | `""` | no |
| aws\_access\_key | Specifies an AWS access key associated with an IAM user or role. | `string` | `""` | no |
| aws\_secret\_key | Specifies the secret key associated with the access key. | `string` | `""` | no |
| aws\_session\_token | Temporary session token used to create instances | `string` | `""` | no |
| eip\_id1 | Instance 1 Elastic IP ID | `string` | `"eipalloc-123456789"` | no |
| eip\_id2 | Instance 2 Elastic IP ID | `string` | `"eipalloc-123456789"` | no |
| instance\_count | Number of instances to create | `number` | `2` | no |
| instance\_type | AWS instance type | `string` | `"m5.large"` | no |
| key\_name | SSH key name | `string` | `"bootstrap_key"` | no |
| mgmt\_plane\_subnet\_id | Management plane subnet ID | `string` | `"subnet-123456789"` | no |
| region | AWS region | `string` | `"us-west-2"` | no |
| test\_plane\_subnet\_id | Test plane subnet ID | `string` | `"subnet-123456789"` | no |
| vpc\_id | VPC ID | `string` | `"vpc-123456789"` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance\_public\_ips | List of public IP addresses assigned to the instances, if applicable |
| test\_plane\_private\_ips | List of private IP addresses assigned to the test interface eth1 of instances, if applicable |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

