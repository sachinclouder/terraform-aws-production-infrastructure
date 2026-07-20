terraform {
  backend "s3" {
    bucket  = "tf-state-045395708836-ap-south-1"
    key     = "environments/dev/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}