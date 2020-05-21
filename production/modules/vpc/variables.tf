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
  description = "ming-2t-apne2-prd-vpc id"
  type = string
  default = "vpc-0384233ccfa1f2ef7"
}

variable "igw_id" {
  description = "ming-2t-apne2-prd-igw id"
  type = string
  default = "igw-0e958d3e1da8fd660"
}

variable "nat_id" {
  description = "ming-2t-apne2-prd-nat id"
  type = string
  default = "nat-0da13258a0d870288"
}