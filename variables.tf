# GENERAL
variable "aws_accountnumber" {
  type        = string
  description = "aws account number"
}

variable "aws_region" {
  type        = string
  description = "aws region"
}

# Tags
variable "environment" {
  type        = string
  description = "environment tag"
}

variable "project" {
  type        = string
  description = "project tag"
}

# VPC
variable "vpc_cidr" {
  type        = string
  description = "CIDR of VPC"
}

variable "vpc_azs" {
  type        = list(string)
  description = "AZs in use within region"
}

variable "private_subnets" {
  type        = list(string)
  description = "private subnet CIDRs"
}

variable "public_subnets" {
  type        = list(string)
  description = "public subnet CIDRs"
}

variable "database_subnets" {
  type        = list(string)
  description = "database subnet CIDRs"
}

# EC2

variable "spot_enabled" {
  type        = bool
  description = "wether to request spot or on-demand instance"
}

variable "instance_type" {
  type        = string
  description = "instance-type of EC2-instance"
}

# DNS

variable "dns_zone" {
  type        = string
  description = "parent DNS hosted public zone"
}

variable "subdomain" {
  type        = string
  description = "subdomain, to create the DNS record for"
}

# RDS
variable "rds_engine" {
  type        = string
  description = "RDS engine to use"
}

variable "rds_engine_version" {
  type        = string
  description = "RDS engine version to use"
}

variable "rds_instance_class" {
  type        = string
  description = "RDS instance class"
}

variable "rds_allocated_storage" {
  type        = string
  description = "RDS allocated storage"
}

variable "rds_max_allocated_storage" {
  type        = string
  description = "RDS max allocated storage"
}

# DB parameter group
variable "rds_family" {
  type        = string
  description = "RDS family for DB parameter group"
}

# DB option group
variable "rds_major_engine_version" {
  type        = string
  description = "RDS major engine version for DB option group"
}

variable "rds_multiaz" {
  type        = bool
  description = "whether to enable RDS Multi AZ feature"
  default     = false
}

variable "rds_backup_retention_period" {
  type        = number
  description = "backup retention period"
  default     = 0
}

variable "rds_database_name" {
  type        = string
  description = "RDS database name"
}

variable "rds_user_name" {
  type        = string
  description = "RDS user name"
}
