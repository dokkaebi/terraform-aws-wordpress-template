output "elastic_ip" {
  value       = aws_eip.wp-eip.public_ip
  description = "elastic IP address of WP instance"
}

output "iam_role_id" {
  value = aws_iam_role.role.id
  description = "id of IAM role"
}
