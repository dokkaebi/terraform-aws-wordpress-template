# EC2-Host with running WP & DB and EIP associated
module "wp-host" {
  source        = "./modules/wp-host"
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.public_subnets[0]
  environment   = var.environment
  project       = var.project
  zone_name     = var.dns_zone
  subdomain     = var.subdomain
  spot_enabled  = var.spot_enabled
  instance_type = var.instance_type
  db_host       = module.wp-db.db_host
  db_name       = var.rds_database_name
  db_user_name  = var.rds_user_name
  db_password   = module.wp-db.db_password
}