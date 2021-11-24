<!-- BEGIN_TF_DOCS -->
# terraform-aws-wordpress-template

This module is used for creating a free-tier infrastructure for running WordPress.

## Requirements

| Name | Version |
|------|---------|
| terraform | >=1.0.10 |
| aws | ~> 3.62.0 |
| kubernetes | ~> 2.5.1 |

## Providers

| Name | Version |
|------|---------|
| aws | 3.62.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| dns-record | ./modules/dns-a-record | n/a |
| vpc | terraform-aws-modules/vpc/aws | 2.78.0 |
| wp-db | ./modules/wp-db | n/a |
| wp-host | ./modules/wp-host | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_accountnumber | aws account number | `string` | n/a | yes |
| aws\_region | aws region | `string` | n/a | yes |
| database\_subnets | database subnet CIDRs | `list(string)` | n/a | yes |
| dns\_zone | parent DNS hosted public zone | `string` | n/a | yes |
| environment | environment tag | `string` | n/a | yes |
| instance\_type | instance-type of EC2-instance | `string` | n/a | yes |
| private\_subnets | private subnet CIDRs | `list(string)` | n/a | yes |
| project | project tag | `string` | n/a | yes |
| public\_subnets | public subnet CIDRs | `list(string)` | n/a | yes |
| rds\_allocated\_storage | RDS allocated storage | `string` | n/a | yes |
| rds\_backup\_retention\_period | backup retention period | `number` | `0` | no |
| rds\_database\_name | RDS database name | `string` | n/a | yes |
| rds\_engine | RDS engine to use | `string` | n/a | yes |
| rds\_engine\_version | RDS engine version to use | `string` | n/a | yes |
| rds\_family | RDS family for DB parameter group | `string` | n/a | yes |
| rds\_instance\_class | RDS instance class | `string` | n/a | yes |
| rds\_major\_engine\_version | RDS major engine version for DB option group | `string` | n/a | yes |
| rds\_max\_allocated\_storage | RDS max allocated storage | `string` | n/a | yes |
| rds\_multiaz | whether to enable RDS Multi AZ feature | `bool` | `false` | no |
| rds\_user\_name | RDS user name | `string` | n/a | yes |
| spot\_enabled | wether to request spot or on-demand instance | `bool` | n/a | yes |
| subdomain | subdomain, to create the DNS record for | `string` | n/a | yes |
| vpc\_azs | AZs in use within region | `list(string)` | n/a | yes |
| vpc\_cidr | CIDR of VPC | `string` | n/a | yes |

## Outputs

No outputs.


<!-- END_TF_DOCS -->