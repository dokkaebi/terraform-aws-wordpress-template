output "db_host" {
  description = "dns name of db_host"
  value       = module.db.db_instance_endpoint
}
