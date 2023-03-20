output "db_host" {
  description = "dns name of db_host"
  value       = module.db.db_instance_endpoint
}

output "db_password" {
  description = "db password"
  value       = module.db.db_instance_password
}