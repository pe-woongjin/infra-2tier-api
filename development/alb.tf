resource "aws_alb_listener" "alb-listener443" {
  load_balancer_arn   = var.alb_id
  port                = 443
  protocol            = "HTTPS"
  certificate_arn     = var.acm_arn

  default_action {
    target_group_arn = aws_alb_target_group.api-ming1-tg8080.arn
    type             = "forward"
  }
}

resource "aws_alb_listener_rule" "alb-listener443-api-rule" {
  listener_arn  = aws_alb_listener.alb-listener443.arn
  depends_on    = [ aws_alb_target_group.api-ming1-tg8080 ]

  action {
    target_group_arn  = aws_alb_target_group.api-ming1-tg8080.arn
    type              = "forward"
  }

  condition {
    host_header {
      values = [ var.hosts.api ]
    }
  }
}