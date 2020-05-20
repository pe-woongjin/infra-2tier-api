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
  ui-ming1-tg8080 = module.ui.ui-ming1-tg8080
  ui-ming2-tg8080 = module.ui.ui-ming2-tg8080

  # api target group
  api-ming1-tg8080 = module.api.api-ming1-tg8080
  api-ming2-tg8080 = module.api.api-ming2-tg8080
}

module "vpc" {
  source = "./modules/vpc"
}

module "api" {
  source = "./services/api"

  # api subnet id list
  api-sn-id = module.vpc.api-sn-id
}

module "ui" {
  source = "./services/ui"

  # ui subnet id list
  ui-sn-id = module.vpc.ui-sn-id
}