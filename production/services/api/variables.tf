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
  default = "ming-2t"
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
# Subnet
# ######################
# api subnet
variable "api_sn_list" {
  description = "private api subnets"
  type = list(map(string))
  default = [
    {
      cidr_block = "10.40.30.0/24",
      availability_zone = "ap-northeast-2a",
      Name = "api-1a-sn"
    },
    {
      cidr_block = "10.40.31.0/24",
      availability_zone = "ap-northeast-2c",
      Name = "api-1c-sn"
    }
  ]
}


# ######################
# Launch Template
# ######################
# api launch template
variable "api_lt" {
  description = "api launch template"
  type = map(string)
  default ={
    "id" = "ami-08ccf8b9f68211181"
    "type" = "t3.small"
    "key_name" = "comp-prod-keypair"
    "min_size" = 0
    "max_size" = 2
  }
}


# ######################
# Output
# ######################
variable "pri-rt-id" {
  description = "private route-table id"
}


# ######################
# Data
# ######################
variable "vpc_id" {
  description = "ming-2t-apne2-prd-vpc id"
  type = string
  default = "vpc-0384233ccfa1f2ef7"
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