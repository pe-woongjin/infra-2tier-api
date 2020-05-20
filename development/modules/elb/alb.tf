resource "aws_alb_listener" "alb-listener443" {
  load_balancer_arn   = var.alb_id
  port                = 443
  protocol            = "HTTPS"
  certificate_arn     = var.acm_arn

  default_action {
    target_group_arn = var.api-ming1-tg8080.arn
    type             = "forward"
  }
}

resource "aws_alb_listener_rule" "alb-listener443-api-rule" {
  listener_arn  = aws_alb_listener.alb-listener443.arn
  depends_on    = [ var.api-ming1-tg8080 ]

  action {
    target_group_arn  = var.api-ming1-tg8080.arn
    type              = "forward"
  }

  condition {
    host_header {
      values = [ var.hosts.api ]
    }
  }
}

resource "aws_alb_listener_rule" "alb-listener443-ui-rule" {
  listener_arn  = aws_alb_listener.alb-listener443.arn
  depends_on    = [ var.ui-ming1-tg8080 ]

  action {
    target_group_arn  = var.ui-ming1-tg8080.arn
    type              = "forward"
  }

  condition {
    host_header {
      values = [ var.hosts.ui ]
    }
  }
}