data "aws_region" "current" {}

data "aws_ssm_parameter" "rds_password" {
  name = "/${var.environment}/database/password"
}