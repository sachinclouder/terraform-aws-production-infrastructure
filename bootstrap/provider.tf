provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "Terraform Bootstrap"
      Environment = "bootstrap"
      ManagedBy   = "Terraform"
      Owner       = "Gaurav Khokher"
    }
  }
}