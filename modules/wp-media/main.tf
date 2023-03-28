
resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.wordpress.id
  acl    = "private"
}

resource "aws_s3_bucket" "wordpress" {
  force_destroy = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "${var.project}-${var.environment}-wp"
  }
}

resource "aws_iam_role_policy" "wordpress" {
  name = "WordPressS3Policy"
  role = var.iam_role_id

  policy = <<EOF
{
	"Version": "2012-10-17",
	
	"Statement": [
	{
		"Effect": "Allow",
		"Action": [
			"s3:CreateBucket",
			"s3:DeleteObject",
			"s3:Put*",
			"s3:Get*",
			"s3:List*"
		],
		"Resource": [
			"${aws_s3_bucket.wordpress.arn}",
			"${aws_s3_bucket.wordpress.arn}/*"
		]
	}
	]
}
EOF
}

resource "aws_s3_bucket_cors_configuration" "example" {
  bucket = aws_s3_bucket.wordpress.id

#   cors_rule {
#     allowed_headers = ["*"]
#     allowed_methods = ["PUT", "POST"]
#     allowed_origins = ["https://s3-website-test.hashicorp.com"]
#     expose_headers  = ["ETag"]
#     max_age_seconds = 3000
#   }

  cors_rule {
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"]
  }
}