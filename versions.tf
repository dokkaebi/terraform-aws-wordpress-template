terraform {

  required_version = ">=1.0.10"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.62.0"
    }
    http = {
      source = "hashicorp/http"
      version = "~> 3.4"
    }
  }
}
