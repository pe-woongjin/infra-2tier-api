resource "aws_alb_listener" "alb-listener443" {
  load_balancer_arn   = var.alb_id
  port                = 443
  protocol            = "HTTPS"
  certificate_arn     = var.acm_arn

  default_action {
    target_group_arn = var.api-a-tg8080.arn
    type             = "forward"
  }
}