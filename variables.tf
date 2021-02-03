variable "ami" {
  description = "The Spirent TestCenter Virtual AMI. When not specified, the latest marketplace image will be used."
  type        = string
  default     = ""

  validation {
    condition     = var.ami == "" || can(regex("^ami-", var.ami))
    error_message = "Please provide a valid ami id, starting with \"ami-\". or leave blank for latest Spirent TestCenter Virtual AMI."
  }
}

variable "vpc_id" {
  description = "AWS VPC ID"
  type        = string

  validation {
    condition     = can(regex("^vpc-", var.vpc_id))
    error_message = "Please provide a valid vpc id, starting with \"vpc-\"."
  }
}

variable "instance_name_prefix" {
  description = "Name assigned to the instance.  An instance number will be appended to the name."
  type        = string
  default     = "stcv-"
}

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 2
}

variable "instance_type" {
  description = "AWS instance type"
  type        = string
  default     = "m5.large"
}

variable "mgmt_plane_subnet_id" {
  description = "Management public AWS subnet ID"
  type        = string

  validation {
    condition     = can(regex("^subnet-", var.mgmt_plane_subnet_id))
    error_message = "Please provide a valid subnet id, starting with \"subnet-\"."
  }
}

variable "mgmt_plane_eips" {
  description = "List of management plane elastic IP IDs.  Leave empty if subnet auto assigns IPs."
  type        = list(string)
  default     = []
}

variable "ingress_cidr_blocks" {
  description = "List of management interface ingress IPv4/IPv6 CIDR ranges"
  type        = list(string)
}

variable "test_plane_subnet_ids" {
  description = "Test plane AWS subnet ID list.  Each instance will have a network interface on each subnet."
  type        = list(string)
}

variable "key_name" {
  description = "AWS SSH key name to assign to each instance"
  type        = string
}

variable "user_data_file" {
  description = "File path name containing AWS user data for the instance.  Spirent TestCenter Virtual cloud-init configuration parameters are supported."
  type        = string
}
