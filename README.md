# Spirent TestCenter Virtual Terraform

## Description
Run STCv traffic generator instances with public and test networks.

Instances can be controlled by the [Spirent TestCenter application](https://github.com/Spirent-terraform-Modules/terraform-aws-stc-gui).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| aws | >= 2.65 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.65 |
| random | n/a |
| template | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [aws_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) |
| [aws_eip_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip_association) |
| [aws_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) |
| [aws_network_interface](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface) |
| [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) |
| [random_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) |
| [template_file](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami | The Spirent TestCenter Virtual AMI. When not specified, the latest marketplace image will be used. | `string` | `""` | no |
| ingress\_cidr\_blocks | List of management interface ingress IPv4/IPv6 CIDR ranges.  Set to empty list when using mgmt\_plane\_security\_group\_ids. | `list(string)` | n/a | yes |
| instance\_count | Number of instances to create | `number` | `2` | no |
| instance\_name\_prefix | Name assigned to the instance.  An instance number will be appended to the name. | `string` | `"stcv-"` | no |
| instance\_type | AWS instance type | `string` | `"m5.large"` | no |
| key\_name | AWS SSH key name to assign to each instance | `string` | n/a | yes |
| mgmt\_plane\_eips | List of management plane elastic IP IDs.  Leave empty if subnet auto assigns IPs. | `list(string)` | `[]` | no |
| mgmt\_plane\_security\_group\_ids | List of management plane security group IDs.  Leave empty to create a default security group using ingress\_cidir\_blocks. | `list(string)` | `[]` | no |
| mgmt\_plane\_subnet\_id | Management public AWS subnet ID | `string` | n/a | yes |
| root\_block\_device | Customize details about the root block device of the instance. See Block Devices below for details. | `list(map(string))` | `[]` | no |
| test\_plane\_security\_group\_ids | List of test plane security group IDs.  Leave empty to create a default security group. | `list(string)` | `[]` | no |
| test\_plane\_subnet\_ids | Test plane AWS subnet ID list.  Each instance will have a network interface on each subnet. | `list(string)` | n/a | yes |
| user\_data\_file | File path name containing AWS user data for the instance.  Spirent TestCenter Virtual cloud-init configuration parameters are supported. | `string` | n/a | yes |
| vpc\_id | AWS VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| instance\_ids | List of instance IDs |
| instance\_private\_ips | List of private IP addresses assigned to the instances, if applicable |
| instance\_public\_ips | List of public IP addresses assigned to the instances, if applicable |
| stcv\_ami | Latest Sprient TestCenter Virtual public AMI |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## User Data (cloud-init)

### Example
```
#cloud-config
spirent:
  driver: dpdk
  speed: 10G
```

### Parameters

| Name | Description |  Type | Default
|------|-------------|-------------|-------------
| speed | Maximum network interface speed | 1G, 5G, 10G, 25G, 50G, 100G | 1G
| driver | Network driver interface | sockets, dpdk | dpdk (for supported cloud provider instances)
| rxq | RX queue size for dpdk driver | 1-N | 1
| benchmark | Turn benchmark rate mode on or off for dpdk driver| off, on | off
| ntp | NTP server | IP address | x.x.x.x (cloud provider recommended)
| ipv4mode | IPv4 address mode | none, static, dhcp | dhcp
| ipaddress | IPv4 address (static mode) | IPv4 address | -
| netmask | IPv4 netmask (static mode) | IPv4 netmask | -
| gwaddress | IPv4 gateway address (static mode) | IPv4 gateway address | -
| ipv6mode | IPv6 address mode | none, static, dhcp | none
| ipv6address | IPv6 address (static mode) | IPv6 address | -
| ipv6prefixlen | IPv6 prefix length (static mode) | IPv6 prefix length | -
| ipv6gwaddress | IPv6 gateway address (static mode) | IPv6 gateway address | -
| gvtap | Turn Gigamon gvtap agent on or off| off, on | off


## Block Devices

### Root Block Device
The root_block_device mapping supports the following:

* delete_on_termination - (Optional) Whether the volume should be destroyed on instance termination. Defaults to true.
* encrypted - (Optional) Whether to enable volume encryption. Defaults to false. Must be configured to perform drift detection.
* iops - (Optional) Amount of provisioned IOPS. Only valid for volume_type of io1, io2 or gp3.
* kms_key_id - (Optional) Amazon Resource Name (ARN) of the KMS Key to use when encrypting the volume. Must be configured to perform drift detection.
* tags - (Optional) A map of tags to assign to the device.
* throughput - (Optional) Throughput to provision for a volume in mebibytes per second (MiB/s). This is only valid for volume_type of gp3.
* volume_size - (Optional) Size of the volume in gibibytes (GiB).
* volume_type - (Optional) Type of volume. Valid values include standard, gp2, gp3, io1, io2, sc1, or st1. Defaults to gp2.
