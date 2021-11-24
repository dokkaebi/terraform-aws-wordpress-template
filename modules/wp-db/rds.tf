module "security_group_db" {
  source              = "terraform-aws-modules/security-group/aws//modules/mysql"
  version             = "~> 4.0"
  name                = "${var.project}-${terraform.workspace}-rds-sg"
  description         = "Security group for rds instance"
  vpc_id              = var.vpc_id
  ingress_cidr_blocks = [var.vpc_cidr]

  tags = {
    Name = "${var.project}-${terraform.workspace}-rds-sg"
  }

}

module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "3.4.1"

  identifier = "${var.project}-${terraform.workspace}-db"

  # All available versions: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt
  engine                = var.rds_engine
  engine_version        = var.rds_engine_version
  instance_class        = var.rds_instance_class
  allocated_storage     = var.rds_allocated_storage
  max_allocated_storage = var.rds_max_allocated_storage
  storage_encrypted     = false

  # DB parameter group
  family = var.rds_family
  # DB option group
  major_engine_version = var.rds_major_engine_version

  name     = var.rds_database_name
  username = var.rds_user_name
  password = data.aws_ssm_parameter.rds_password.value
  port     = "3306"

  # use security group created above
  vpc_security_group_ids = [module.security_group_db.security_group_id]
  #maintenance_window     = "Mon:00:00-Mon:03:00"
  #backup_window          = "03:00-06:00"
  skip_final_snapshot = true
  multi_az            = var.rds_multiaz

  apply_immediately = true

  # disable backups to create DB faster
  backup_retention_period = var.rds_backup_retention_period

  # DB subnet group
  subnet_ids = var.rds_database_subnet_ids

  # Database Deletion Protection
  deletion_protection = false

  # char set
  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]
}