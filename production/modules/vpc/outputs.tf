output "pri-rt-ids" {
  value = aws_route_table.pri-rt.*.id[0]
}