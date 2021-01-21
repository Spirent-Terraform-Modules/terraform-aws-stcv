variable "ami" {
  description = "The Spirent TestCenter Virtual AMI. When not specified, the latest marketplace image will be used."
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "AWS vpc id"
  type        = string
  default     = ""
}

variable "instance_name" {
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

variable "mgmt_plane_subnet" {
  description = "Management public AWS subnet id"
  type        = string
}

variable "ingress_cidr_blocks" {
  description = "List of management interface ingress IPv4/IPv6 CIDR ranges."
  type        = list(string)
}

variable "test_plane_subnets" {
  description = "Test network AWS subnet id list.  Each instance will have a network interface on each subnet."
  type        = list(string)
}

variable "key_name" {
  description = "AWS SSH key name to assign to the instance."
  type        = string
}

variable "user_data_file" {
  description = "File path name containing AWS user data for the instance.  Spirent TestCenter Virtual cloud-init configuration parameters are supported."
  type        = string
}
