variable "iam_role_id" {
  type        = string
  description = "id of the IAM role that should get S3 access"
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
