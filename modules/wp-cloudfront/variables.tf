
variable "bucket" {
  type = object({
    bucket_regional_domain_name         = string
    arn        = string
    id = string
  })
  description = "the source s3 bucket"
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
