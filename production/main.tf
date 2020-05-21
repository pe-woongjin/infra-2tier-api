terraform {
  required_version = "~> 0.12.20"

  backend "s3" {
    bucket          = "terraform-tfstates-mgmt"
    key             = "terraform/infra-2tier/services/terraform.tfstate"
    region          = "ap-northeast-2"
    dynamodb_table  = "terraform-lock-table"
    encrypt         = true
    acl             = "bucket-owner-full-control"
  }
}

provider "aws" {
  version                   = "~> 2.51"
  region                    = "ap-northeast-2"
  shared_credentials_file   = "~/.aws/credentials"
}

module "elb" {
  source = "./modules/elb"

  # ui target group
  ui-a-tg80 = module.ui.ui-a-tg80
  ui-b-tg80 = module.ui.ui-b-tg80

  # api target group
  api-a-tg8080 = module.api.api-a-tg8080
  api-b-tg8080 = module.api.api-b-tg8080
}

module "vpc" {
  source = "./modules/vpc"
}

module "api" {
  source = "./services/api"

  # private route-table id
  pri-rt-id = module.vpc.pri-rt-id
}

module "ui" {
  source = "./services/ui"

  # private route-table id
  pri-rt-id = module.vpc.pri-rt-id
}