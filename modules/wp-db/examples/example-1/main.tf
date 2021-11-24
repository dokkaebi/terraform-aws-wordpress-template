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