output "elastic_ip" {
  value       = aws_eip.wp-eip.public_ip
  description = "elastic IP address of WP instance"
}