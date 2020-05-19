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
  default = "base"
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
  resrc_prefix_nm =  "${var.service_name}-${var.region_nm}-${var.environment}"
}


# ######################
# Subnet
# ######################
# pri subnet
variable "pri_sn_list" {
  description = "private subnets"
  type = list(map(string))
  default =[
    {
      cidr_block = "10.40.20.0/24",
      availability_zone = "ap-northeast-2a",
      Name = "pri-1a-sn"
    },
    {
      cidr_block = "10.40.21.0/24",
      availability_zone = "ap-northeast-2c",
      Name = "pri-1c-sn"
    }
  ]
}

# api subnet
variable "api_sn_list" {
  description = "private api subnets"
  type = list(map(string))
  default =[
    {
      cidr_block = "10.40.60.0/24",
      availability_zone = "ap-northeast-2a",
      Name = "api-1a-sn"
    },
    {
      cidr_block = "10.40.61.0/24",
      availability_zone = "ap-northeast-2c",
      Name = "api-1c-sn"
    }
  ]
}


# ######################
# Route Table
# ######################
# private route table
variable "private_rt_tag_names" {
  description = "tag name for private route table"
  type = list(map(string))
  default =[
    {
      Name = "pri-rt"
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
# Route 53
# ######################
# route 53 host name
variable "hosts" {
  description = "route 53 host name"
  type = map(string)
  default ={
    "api" = "api-2tier.mingming.shop"
  }
}


# ######################
# Data
# ######################
variable "alb_id" {
  description = "base-apne2-prd-alb id"
  type = string
  default = "arn:aws:elasticloadbalancing:ap-northeast-2:144149479695:loadbalancer/app/base-apne2-prd-alb/ad80c6ca2f9aaa69"
}

variable "vpc_id" {
  description = "base-apne2-prd-vpc id"
  type = string
  default = "vpc-0cee52b990d29d6a2"
}

variable "igw_id" {
  description = "base-apne2-prd-igw id"
  type = string
  default = "igw-0aad41050674feda8"
}

variable "nat_id" {
  description = "base-apne2-prd-nat id"
  type = string
  default = "nat-09a23e75ee31034ad"
}

variable "ec2_role_name" {
  description = "ec2 role name"
  type = string
  default = "codedeploy-ec2-role"
}

variable "cd_role_name" {
  description = "code deploy role name"
  type = string
  default = "codedeploy-role"
}

variable "acm_arn" {
  description = "acm arn"
  type = string
  default = "arn:aws:acm:ap-northeast-2:144149479695:certificate/efc7a467-526d-4476-b91f-ef69f146c6a6"
}