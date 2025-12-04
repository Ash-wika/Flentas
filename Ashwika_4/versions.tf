terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# The AWS Budgets service is global, but its resources must be configured in the 
# 'us-east-1' (N. Virginia) region, as this is where AWS Billing data resides.
provider "aws" {
  region = "us-east-1"
}