terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.91.0"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      resource = var.resource
      iac      = var.iac
      project  = var.project
    }
  }
}

# Add this data source to retrieve the AWS account ID
data "aws_caller_identity" "current" {}