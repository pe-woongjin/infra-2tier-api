resource "aws_alb_listener_rule" "alb-listener443-ui-rule" {
  listener_arn  = var.alb-listener443.arn
  depends_on    = [ aws_alb_target_group.ui-a-tg80 ]

  action {
    target_group_arn  = aws_alb_target_group.ui-a-tg80.arn
    type              = "forward"
  }

  condition {
    host_header {
      values = [ var.hosts.ui ]
    }
  }
}