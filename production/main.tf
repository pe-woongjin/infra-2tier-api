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

  # output
  api-a-tg8080 = module.api.api-a-tg8080

  # imported data
  alb_id    = var.alb_id
  acm_arn   = var.acm_arn
}

module "vpc" {
  source = "./modules/vpc"

  # common
  environment       = var.environment
  resrc_prefix_nm   = local.resrc_prefix_nm

  # resource
  private_rt_tag_names = var.private_rt_tag_names

  # imported data
  vpc_id  = var.vpc_id
  igw_id  = var.igw_id
  nat_id  = var.nat_id
}

module "api" {
  source = "./services/api"

  # common
  environment       = var.environment
  resrc_prefix_nm   = local.resrc_prefix_nm

  # resource
  api_sn_list   = var.api_sn_list
  api_lt        = var.api_lt
  hosts         = var.hosts

  # output
  pri-rt-ids        = module.vpc.pri-rt-ids
  alb-listener443   = module.elb.alb-listener443

  # imported data
  vpc_id          = var.vpc_id
  ec2_role_name   = var.ec2_role_name
  cd_role_name    = var.cd_role_name
}

module "ui" {
  source = "./services/ui"

  # common
  environment       = var.environment
  resrc_prefix_nm   = local.resrc_prefix_nm

  # resource
  ui_sn_list  = var.ui_sn_list
  ui_lt       = var.ui_lt
  hosts       = var.hosts

  # output
  pri-rt-ids        = module.vpc.pri-rt-ids
  alb-listener443   = module.elb.alb-listener443

  # imported data
  vpc_id          = var.vpc_id
  ec2_role_name   = var.ec2_role_name
  cd_role_name    = var.cd_role_name
}