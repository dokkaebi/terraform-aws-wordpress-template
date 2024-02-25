data "aws_region" "current" {}

data "http" "myip" {
  url = "https://ipv4.icanhazip.com"
}
