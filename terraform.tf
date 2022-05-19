terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"

  default_tags {
    tags = {
      CreatedBy   = "Matt Canty"
      CreatedOn   = "2022-05-19"
      Purpose     = "Testing VPC restriction on IAM user policy"
      DeleteAfter = "2022-09-01"
    }
  }
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
