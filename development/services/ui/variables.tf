# ######################
# COMMON
# ######################
variable "team_name" {
  description = "team name of DevOps"
  type = string
  default = "PE"
}

variable "service_name" {
  description = "name of service"
  type = string
  default = "ming"
}

variable "service_version" {
  description = "version of service"
  type = string
  default = "0.1"
}

variable "environment" {
  description = "Runtime Environment such as default, develop, stage, production"
  type = string
  default = "prd"
}

variable "region_nm" {
  description = "aws region alias"
  type = string
  default = "apne2"
}

locals {
  resrc_prefix_nm = "${var.service_name}-${var.region_nm}-${var.environment}"
}


# ######################
# Launch Template
# ######################
# ui launch template
variable "ui_lt" {
  description = "ui launch template"
  type = map(string)
  default = {
    "id" = "ami-04df341f89c111637"
    "type" = "t3.small"
    "key_name" = "comp-prod-keypair"
    "min_size" = 0
    "max_size" = 2
  }
}


# ######################
# Output
# ######################
variable "ui-sn-id" {
  description = "ui subnet id list"
}


# ######################
# Data
# ######################
variable "vpc_id" {
  description = "ming-apne2-prd-vpc id"
  type = string
  default = "vpc-0cee52b990d29d6a2"
}

variable "ec2_role_name" {
  description = "ec2 role name"
  type = string
  default = "codedeploy-ec2-role-profile"
}

variable "cd_role_name" {
  description = "code deploy role name"
  type = string
  default = "codedeploy-role"
}