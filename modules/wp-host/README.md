<!-- BEGIN_TF_DOCS -->
# wp-host

This module is used for creating a EC2-instance running Wordpress.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | 3.62.0 |
| local | n/a |
| tls | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| ec2\_instance | terraform-aws-modules/ec2-instance/aws | ~> 3.0 |
| key\_pair | terraform-aws-modules/key-pair/aws | v0.6.0 |
| security\_group | terraform-aws-modules/security-group/aws | ~> 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| db\_host | db-host WP should connect to | `string` | n/a | yes |
| db\_name | db-name WP should use | `string` | n/a | yes |
| db\_password | db-password WP should use | `string` | n/a | yes |
| db\_user\_name | db-user-name WP should use | `string` | n/a | yes |
| environment | environment of the project | `string` | n/a | yes |
| instance\_type | instance type of ec2 instance | `string` | n/a | yes |
| project | project name | `string` | n/a | yes |
| spot\_enabled | whether to provision EC2-instance as spot or on-demand instance | `bool` | n/a | yes |
| subdomain | subdomain unter that WP should be reachable | `string` | n/a | yes |
| subnet\_id | subnet id, the EC2-instance should be provisioned in | `string` | n/a | yes |
| tls\_server\_crt | TLS server certificate | `string` | n/a | yes |
| tls\_server\_key | TLS cert key | `string` | n/a | yes |
| vpc\_id | VPC ID the EC2-instance should get attached to | `string` | n/a | yes |
| zone\_name | parent dns public hosted zone | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| elastic\_ip | elastic IP address of WP instance |



Example
---
**NOTE**
---
```hcl
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
```
<!-- END_TF_DOCS -->