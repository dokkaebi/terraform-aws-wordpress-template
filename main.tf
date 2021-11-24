/**
 * # terraform-aws-wordpress-template
 *
 * This module is used for creating a free-tier infrastructure for running WordPress.
 *
 */

# Networking
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.78.0"
  name    = "${var.project}-${terraform.workspace}-vpc"
  cidr    = var.vpc_cidr

  azs              = var.vpc_azs
  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets
  database_subnets = var.database_subnets

  enable_nat_gateway           = false
  single_nat_gateway           = true
  enable_dns_hostnames         = true
  enable_dns_support           = true
  enable_vpn_gateway           = false
  create_database_subnet_group = false
}

# DNS A record
module "dns-record" {
  source     = "./modules/dns-a-record"
  dns_zone   = var.dns_zone
  subdomain  = var.subdomain
  ip-address = module.wp-host.elastic_ip
  ttl        = "60"
}


# RDS for WP
module "wp-db" {
  source                    = "./modules/wp-db"
  vpc_id                    = module.vpc.vpc_id
  vpc_cidr                  = module.vpc.vpc_cidr_block
  rds_database_subnet_ids   = module.vpc.database_subnets
  rds_allocated_storage     = var.rds_allocated_storage
  rds_database_name         = var.rds_database_name
  rds_engine                = var.rds_engine
  rds_engine_version        = var.rds_engine_version
  rds_family                = var.rds_family
  rds_instance_class        = var.rds_instance_class
  rds_major_engine_version  = var.rds_major_engine_version
  rds_max_allocated_storage = var.rds_max_allocated_storage
  rds_user_name             = var.rds_user_name
  environment               = var.environment
  project                   = var.project
}

# EC2-Host with running WP and associated EIP
module "wp-host" {
  source         = "./modules/wp-host"
  vpc_id         = module.vpc.vpc_id
  subnet_id      = module.vpc.public_subnets[0]
  environment    = var.environment
  project        = var.project
  zone_name      = var.dns_zone
  subdomain      = var.subdomain
  spot_enabled   = var.spot_enabled
  instance_type  = var.instance_type
  db_host        = module.wp-db.db_host
  db_name        = var.rds_database_name
  db_user_name   = var.rds_user_name
  db_password    = module.wp-db.db_password
  tls_server_crt = file("${path.module}/certs/server.crt")
  tls_server_key = file("${path.module}/certs/server.key")
}