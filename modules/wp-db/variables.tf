variable "vpc_id" {
  type        = string
  description = "VPC ID the EC2-instance should get attached to"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR"
}

variable "environment" {
  type        = string
  description = "environment of the project"
}

variable "project" {
  type        = string
  description = "project name"
}

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

variable "rds_database_subnet_ids" {
  type        = list(string)
  description = "list of database subnet IDs from VPC-module"
}

variable "rds_database_name" {
  type        = string
  description = "RDS database name"
}

variable "rds_user_name" {
  type        = string
  description = "RDS user name"
}
