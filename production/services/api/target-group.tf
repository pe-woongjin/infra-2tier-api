resource "aws_alb_target_group" "api-a-tg8080" {
  name          = "${var.resrc_prefix_nm}-api-a-tg8080"
  protocol      = "HTTP"
  port          = 8080
  target_type   = "instance"
  vpc_id        = var.vpc_id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 10
    matcher             = "200"
    path                = "/health"
  }

  tags = {
    Name          = "${var.resrc_prefix_nm}-api-a-tg8080"
    Environment   = var.environment
  }
}

resource "aws_alb_target_group" "api-b-tg8080" {
  name          = "${var.resrc_prefix_nm}-api-b-tg8080"
  protocol      = "HTTP"
  port          = 8080
  target_type   = "instance"
  vpc_id        = var.vpc_id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 10
    matcher             = "200"
    path                = "/health"
  }

  tags = {
    Name          = "${var.resrc_prefix_nm}-api-b-tg8080"
    Environment   = var.environment
  }
}