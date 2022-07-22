# we provision resources only in aws region which is defined by the variables
provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

#use -backend-config parameter to send backend s3 details, example : 
# terraform init -backend-config=backends/dev-env.tf
/* terraform {
  backend "s3" {}
} */