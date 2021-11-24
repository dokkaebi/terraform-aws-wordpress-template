<!-- BEGIN_TF_DOCS -->
# wp-db

This module is used for creating a RDS database server for usage with Wordpress.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| db | terraform-aws-modules/rds/aws | 3.4.1 |
| security\_group\_db | terraform-aws-modules/security-group/aws//modules/mysql | ~> 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment | environment of the project | `string` | n/a | yes |
| project | project name | `string` | n/a | yes |
| rds\_allocated\_storage | RDS allocated storage | `string` | n/a | yes |
| rds\_backup\_retention\_period | backup retention period | `number` | `0` | no |
| rds\_database\_name | RDS database name | `string` | n/a | yes |
| rds\_database\_subnet\_ids | list of database subnet IDs from VPC-module | `list(string)` | n/a | yes |
| rds\_engine | RDS engine to use | `string` | n/a | yes |
| rds\_engine\_version | RDS engine version to use | `string` | n/a | yes |
| rds\_family | RDS family for DB parameter group | `string` | n/a | yes |
| rds\_instance\_class | RDS instance class | `string` | n/a | yes |
| rds\_major\_engine\_version | RDS major engine version for DB option group | `string` | n/a | yes |
| rds\_max\_allocated\_storage | RDS max allocated storage | `string` | n/a | yes |
| rds\_multiaz | whether to enable RDS Multi AZ feature | `bool` | `false` | no |
| rds\_user\_name | RDS user name | `string` | n/a | yes |
| vpc\_cidr | VPC CIDR | `string` | n/a | yes |
| vpc\_id | VPC ID the EC2-instance should get attached to | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| db\_host | dns name of db\_host |
| db\_password | db password |



Example
---
**NOTE**
---
```hcl
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
```
<!-- END_TF_DOCS -->