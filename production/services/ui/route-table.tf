resource "aws_route_table_association" "ui-rt-ac" {
  count           = length(aws_subnet.ui-sn)

  subnet_id       = aws_subnet.ui-sn.*.id[count.index]
  route_table_id  = var.pri-rt-id
}