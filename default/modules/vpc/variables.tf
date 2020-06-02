# ######################
# COMMON
# ######################
variable "environment" {
  type = string
}

variable "resrc_prefix_nm" {
  type = string
}


# ######################
# Route Table
# ######################
# private route table
variable "private_rt_tag_names" {
  type = list(map(string))
}


# ######################
# Imported data
# ######################
variable "vpc_id" {
  type = string
}

variable "igw_id" {
  type = string
}

variable "nat_id" {
  type = string
}