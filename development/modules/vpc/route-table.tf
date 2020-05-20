resource "aws_route_table" "pri-rt" {
  vpc_id            = var.vpc_id
  count             = length(var.private_rt_tag_names)
  depends_on        = [ var.igw_id, var.nat_id ]

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = var.nat_id
  }

  tags = {
    Name          = "${local.resrc_prefix_nm}-${lookup(var.private_rt_tag_names[count.index], "Name")}"
    Environment   = var.environment
  }
}

resource "aws_route_table_association" "pri-rt-ac" {
  count           = length(aws_subnet.pri-sn)

  subnet_id       = aws_subnet.pri-sn.*.id[count.index]
  route_table_id  = aws_route_table.pri-rt.*.id[0]
}

resource "aws_route_table_association" "ui-rt-ac" {
  count           = length(aws_subnet.ui-sn)

  subnet_id       = aws_subnet.ui-sn.*.id[count.index]
  route_table_id  = aws_route_table.pri-rt.*.id[0]
}

resource "aws_route_table_association" "api-rt-ac" {
  count           = length(aws_subnet.api-sn)

  subnet_id       = aws_subnet.api-sn.*.id[count.index]
  route_table_id  = aws_route_table.pri-rt.*.id[0]
}