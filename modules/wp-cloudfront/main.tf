module "cdn" {
  source = "cloudposse/cloudfront-s3-cdn/aws"
  # Cloud Posse recommends pinning every module to a specific version
  # version = "x.x.x"

  # namespace         = "eg"
  # stage             = "prod"
  name              = "cdn"

  origin_bucket = var.bucket.id

  # aliases           = ["assets.cloudposse.com"]
  # dns_alias_enabled = true
  # parent_zone_name  = "cloudposse.com"

  # deployment_principal_arns = {
  #   "arn:aws:iam::123456789012:role/principal1" = ["prefix1/", "prefix2/"]
  #   "arn:aws:iam::123456789012:role/principal2" = [""]
  # }


  cached_methods   = ["GET", "HEAD"]
  allowed_methods  = ["GET", "HEAD", "OPTIONS"]
  # "CachingOptimized" managed policy
  cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
  # "CORS-S3Origin" managed policy
  origin_request_policy_id = "88a5eaf4-2fd4-4709-b370-b4c650ea3fcf"

  cloudfront_access_logging_enabled = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "${var.project}-${var.environment}-wp"
  }


}



# resource "aws_cloudfront_origin_access_identity" "default" {}

# resource "aws_cloudfront_origin_access_control" "default" {
#   name                              = "default"
#   description                       = "Default Policy"
#   origin_access_control_origin_type = "s3"
#   signing_behavior                  = "always"
#   signing_protocol                  = "sigv4"
# }

# data "aws_iam_policy_document" "s3_policy" {
#   statement {
#     actions   = ["s3:GetObject"]
#     resources = ["${var.bucket.arn}/*"]

#     principals {
#       type        = "AWS"
#       identifiers = [aws_cloudfront_origin_access_identity.default.iam_arn]
#     }
#   }
# }

# resource "aws_s3_bucket_policy" "example" {
#   bucket = var.bucket.id
#   policy = data.aws_iam_policy_document.s3_policy.json
# }

# locals {
#   s3_origin_id = "myS3Origin"
# }

# resource "aws_cloudfront_distribution" "s3_distribution" {
#   origin {
#     domain_name              = var.bucket.bucket_regional_domain_name
#     origin_access_control_id = aws_cloudfront_origin_access_control.default.id
#     origin_id                = local.s3_origin_id
#   }

#   enabled             = true
#   is_ipv6_enabled     = true

# #   aliases = ["mysite.example.com", "yoursite.example.com"]

#   default_cache_behavior {
#     allowed_methods  = ["GET", "HEAD", "OPTIONS"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = local.s3_origin_id

#     # "CachingOptimized" managed policy
#     cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"

#     # "CORS-S3Origin" managed policy
#     origin_request_policy_id = "88a5eaf4-2fd4-4709-b370-b4c650ea3fcf"

#     viewer_protocol_policy = "allow-all"
#     min_ttl                = 0
#     default_ttl            = 3600
#     max_ttl                = 86400
#   }

#   restrictions {
#     geo_restriction {
#       restriction_type = "none"
#       locations        = []
#     }
#   }

# # PriceClass_100 or PriceClass_200 excludes some regions
# # worth considering after free tier expires
# #   price_class = "PriceClass_200"

#   tags = {
#     Terraform   = "true"
#     Environment = "dev"
#     Name        = "${var.project}-${var.environment}-wp"
#   }

#   viewer_certificate {
#     cloudfront_default_certificate = true
#   }
# }
