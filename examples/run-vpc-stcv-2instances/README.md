
Create a VPC with public and private subnets and run 2 Spirent TestCenter Virtual traffic generator instances.


Instances can be controlled by the Spirent TestCenter application.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| azs | AWS availability zone list | `list` | <pre>[<br>  "us-east-1a"<br>]</pre> | no |
| key\_name | SSH key name | `string` | `"bootstrap_key"` | no |
| region | AWS region | `string` | `"us-east-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance\_public\_ip | List of public IP addresses assigned to the instances, if applicable |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

