
Run STCv traffic generator instances with public and test networks.

Instances can be controlled by the Spirent TestCenter application.

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
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami | The Spirent TestCenter Virtual AMI. When not specified, the latest marketplace image will be used. | `string` | `""` | no |
| ingress\_cidr\_blocks | List of management interface ingress IPv4/IPv6 CIDR ranges. | `list(string)` | n/a | yes |
| instance\_count | Number of instances to create | `number` | `2` | no |
| instance\_name | Name assigned to the instance.  An instance number will be appended to the name. | `string` | `"stcv-"` | no |
| instance\_type | AWS instance type | `string` | `"m5.large"` | no |
| key\_name | AWS SSH key name to assign to the instance. | `string` | n/a | yes |
| mgmt\_plane\_subnet | Management public AWS subnet id | `string` | n/a | yes |
| test\_plane\_subnets | Test network AWS subnet id list.  Each instance will have a network interface on each subnet. | `list(string)` | n/a | yes |
| user\_data\_file | File path name containing AWS user data for the instance.  Spirent TestCenter Virtual cloud-init configuration parameters are supported. | `string` | n/a | yes |
| vpc\_id | AWS VPC ID | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | List of IDs of instances |
| private\_ip | List of private IP addresses assigned to the instances, if applicable |
| public\_ip | List of public IP addresses assigned to the instances, if applicable |
| stcv\_ami | Latest Sprient TestCenter Virtual Pulic AMI |

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
| netmask | IPv4 netmask (static mode) | IPv4 netmaks | -  
| gwaddress | IPv4 gateway address (static mode) | IPv4 gateway address | - 
| ipv6mode | IPv6 address mode | none, static, dhcp | none
| ipv6address | IPv4 address (static mode) | IPv4 address | - 
| ipv6prefixlen | IPv6 prefix length (static mode) | IPv4 netmaks | -  
| ipv6gwaddress | IPv4 gateway address (static mode) | IPv6 gateway address | - 
| gvtap | Turn Gigamon gvtap agent on or off| off, on | off
