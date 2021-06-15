
Create a VPC with public and private subnets and run 2 Spirent TestCenter Virtual traffic generator instances.

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
| vpc | terraform-aws-modules/vpc/aws |  |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_access\_key | Specifies an AWS access key associated with an IAM user or role. | `string` | `""` | no |
| aws\_secret\_key | Specifies the secret key associated with the access key. | `string` | `""` | no |
| aws\_session\_token | Temporary session token used to create instances | `string` | `""` | no |
| azs | AWS availability zone list | `list` | <pre>[<br>  "us-east-1a"<br>]</pre> | no |
| instance\_type | AWS instance type | `string` | `"m5.large"` | no |
| key\_name | SSH key name | `string` | `"bootstrap_key"` | no |
| region | AWS region | `string` | `"us-east-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance\_public\_ip | List of public IP addresses assigned to the instances, if applicable |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

