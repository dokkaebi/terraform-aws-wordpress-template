/**
 * # wp-host
 *
 * This module is used for creating a EC2-instance for usage with Wordpress
 *
 */

resource "aws_iam_role" "role" {
  name = "${local.name_prefix}-role"

  assume_role_policy = file("${path.module}/iam/ec2-assumerole.json")

  tags = {
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "ssm-policy" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}


resource "aws_iam_instance_profile" "profile" {

  name = "${local.name_prefix}-profile"
  role = aws_iam_role.role.name
}