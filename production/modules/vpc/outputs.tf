output "pri-rt-id" {
  value = aws_route_table.pri-rt.*.id[0]
}