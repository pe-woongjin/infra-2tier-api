resource "aws_subnet" "pri-sn" {
  vpc_id                    = var.vpc_id
  count                     = length(var.pri_sn_list)
  cidr_block                = lookup(var.pri_sn_list[count.index], "cidr_block")
  availability_zone         = lookup(var.pri_sn_list[count.index], "availability_zone")
  depends_on                = [ aws_route_table.pri-rt ]

  map_public_ip_on_launch   = false

  tags = {
    Name          = "${local.resrc_prefix_nm}-${lookup(var.pri_sn_list[count.index], "Name")}"
    Environment   = var.environment
  }
}

resource "aws_subnet" "ui-sn" {
  vpc_id                    = var.vpc_id
  count                     = length(var.ui_sn_list)
  cidr_block                = lookup(var.ui_sn_list[count.index], "cidr_block")
  availability_zone         = lookup(var.ui_sn_list[count.index], "availability_zone")

  map_public_ip_on_launch   = false

  tags = {
    Name         = "${local.resrc_prefix_nm}-${lookup(var.ui_sn_list[count.index], "Name")}"
    Environment  = var.environment
  }
}

resource "aws_subnet" "api-sn" {
  vpc_id                    = var.vpc_id
  count                     = length(var.api_sn_list)
  cidr_block                = lookup(var.api_sn_list[count.index], "cidr_block")
  availability_zone         = lookup(var.api_sn_list[count.index], "availability_zone")

  map_public_ip_on_launch   = false

  tags = {
    Name          = "${local.resrc_prefix_nm}-${lookup(var.api_sn_list[count.index], "Name")}"
    Environment   = var.environment
  }
}