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