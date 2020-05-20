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
# Subnet
# ######################
# pri subnet
variable "pri_sn_list" {
  description = "private subnets"
  type = list(map(string))
  default = [
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

# ui subnet
variable "ui_sn_list" {
  description = "private ui subnets"
  type = list(map(string))
  default = [
    {
      cidr_block = "10.40.50.0/24",
      availability_zone = "ap-northeast-2a",
      Name = "ui-1a-sn"
    },
    {
      cidr_block = "10.40.51.0/24",
      availability_zone = "ap-northeast-2c",
      Name = "ui-1c-sn"
    }
  ]
}

# api subnet
variable "api_sn_list" {
  description = "private api subnets"
  type = list(map(string))
  default = [
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
  default = [
    {
      Name = "pri-rt"
    }
  ]
}


# ######################
# Data
# ######################
variable "vpc_id" {
  description = "ming-apne2-prd-vpc id"
  type = string
  default = "vpc-0cee52b990d29d6a2"
}

variable "igw_id" {
  description = "ming-apne2-prd-igw id"
  type = string
  default = "igw-0aad41050674feda8"
}

variable "nat_id" {
  description = "ming-apne2-prd-nat id"
  type = string
  default = "nat-09a23e75ee31034ad"
}