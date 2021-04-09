output "stcv_ami" {
  description = "Latest Sprient TestCenter Virtual public AMI"
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

output "test_plane_private_ips" {
  description = "List of private IP addresses assigned to the test interface eth1 of instances, if applicable"
  value       = aws_network_interface.test_plane.*.private_ips
}