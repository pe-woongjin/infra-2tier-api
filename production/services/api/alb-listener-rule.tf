resource "aws_alb_listener_rule" "alb-listener443-api-rule" {
  listener_arn  = var.alb-listener443.arn
  depends_on    = [ aws_alb_target_group.api-a-tg8080 ]

  action {
    target_group_arn  = aws_alb_target_group.api-a-tg8080.arn
    type              = "forward"
  }

  condition {
    host_header {
      values = [ var.hosts.api ]
    }
  }
}