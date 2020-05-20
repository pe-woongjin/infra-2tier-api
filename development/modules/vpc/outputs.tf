output "ui-sn-id" {
  value = aws_subnet.ui-sn.*.id
}

output "api-sn-id" {
  value = aws_subnet.api-sn.*.id
}