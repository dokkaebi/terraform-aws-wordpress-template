# General
environment = "demo"
project     = "example"

# aws accountnumber
aws_accountnumber = "<your-account-number>"

# VPC
vpc_cidr         = "172.35.0.0/16"
aws_region       = "us-west-2"
vpc_azs          = ["us-west-2a", "us-west-2b"]
private_subnets  = ["172.35.1.0/24", "172.35.2.0/24"]
public_subnets   = ["172.35.101.0/24", "172.35.102.0/24"]
database_subnets = ["172.35.3.0/24", "172.35.4.0/24"]

# DNS
dns_zone  = "<your-public-hosted-zone>"
subdomain = "www"

# EC2
spot_enabled  = false
instance_type = "t3.micro"


### RDS
rds_multiaz                 = false
rds_instance_class          = "db.t4g.micro"
rds_engine                  = "mysql"
rds_engine_version          = "5.7"
rds_allocated_storage       = 5
rds_max_allocated_storage   = 20
rds_family                  = "mysql5.7"
rds_major_engine_version    = "5.7"
rds_backup_retention_period = 0
rds_database_name           = "wp"
rds_user_name               = "wordpress"
