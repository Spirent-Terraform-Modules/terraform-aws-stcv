output "stcv_ami" {
  description = "Latest Sprient TestCenter Virtual Pulic AMI"
  value       = data.aws_ami.stcv.id
}

output "instance_ids" {
  description = "List of instance IDs"
  value       = aws_instance.stcv.*.id
}


output "instance_public_ips" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = aws_instance.stcv.*.public_ip
}

output "instance_private_ips" {
  description = "List of private IP addresses assigned to the instances, if applicable"
  value       = aws_instance.stcv.*.private_ip
}
