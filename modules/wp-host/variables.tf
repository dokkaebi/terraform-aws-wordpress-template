variable "vpc_id" {
  type        = string
  description = "VPC ID the EC2-instance should get attached to"
}

variable "subnet_id" {
  type        = string
  description = "subnet id, the EC2-instance should be provisioned in"
}

variable "environment" {
  type        = string
  description = "environment of the project"
}

variable "project" {
  type        = string
  description = "project name"
}

variable "zone_name" {
  type        = string
  description = "parent dns public hosted zone"
}

variable "subdomain" {
  type        = string
  description = "subdomain unter that WP should be reachable"
}

variable "spot_enabled" {
  type        = bool
  description = "whether to provision EC2-instance as spot or on-demand instance"
}

variable "instance_type" {
  type        = string
  description = "instance type of ec2 instance"
}

variable "db_host" {
  type        = string
  description = "db-host WP should connect to"
}

variable "db_name" {
  type        = string
  description = "db-name WP should use"
}

variable "db_user_name" {
  type        = string
  description = "db-user-name WP should use"
}

variable "db_password" {
  type        = string
  description = "db-password WP should use"
}

variable "tls_server_crt" {
  type        = string
  description = "TLS server certificate"
}

variable "tls_server_key" {
  type        = string
  description = "TLS cert key"
}