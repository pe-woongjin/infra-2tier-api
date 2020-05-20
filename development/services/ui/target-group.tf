resource "aws_alb_target_group" "ui-a-tg80"  {
  name          = "${local.resrc_prefix_nm}-ui-a-tg80"
  protocol      = "HTTP"
  port          = 80
  target_type   = "instance"
  vpc_id        = var.vpc_id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 10
    matcher             = "200"
    path                = "/"
  }

  tags = {
    Name          = "${local.resrc_prefix_nm}-ui-a-tg80"
    Environment   = var.environment
  }
}

resource "aws_alb_target_group" "ui-b-tg80"  {
  name          = "${local.resrc_prefix_nm}-ui-b-tg80"
  protocol      = "HTTP"
  port          = 80
  target_type   = "instance"
  vpc_id        = var.vpc_id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 10
    matcher             = "200"
    path                = "/"
  }

  tags = {
    Name          = "${local.resrc_prefix_nm}-ui-b-tg80"
    Environment   = var.environment
  }
}