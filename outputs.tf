# OUTPUTS

output "spirent_ami" {
  description = "Latest Sprient TestCenter Virtual Pulic AMI"
  value       = data.aws_ami.spirent_ami.id
}

output "id" {
  description = "List of IDs of instances"
  value       = aws_instance.stcv.*.id
}


output "public_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = aws_instance.stcv.*.public_ip
}

output "private_ip" {
  description = "List of private IP addresses assigned to the instances, if applicable"
  value       = aws_instance.stcv.*.private_ip
}
