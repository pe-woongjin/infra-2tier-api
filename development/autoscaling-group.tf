resource "aws_autoscaling_group" "api-ming1-asg" {
  name                  = "${local.resrc_prefix_nm}-api-ming1-asg"
  vpc_zone_identifier   = [ aws_subnet.api-sn[0].id, aws_subnet.api-sn[1].id ]

  launch_template {
    id      = aws_launch_template.api-lt.id
    version = "$Latest"
  }

  target_group_arns     = [ aws_alb_target_group.api-ming1-tg8080.arn ]
  health_check_type     = "ELB"

  min_size              = var.api_lt.min_size
  max_size              = var.api_lt.max_size

  tag {
    key                 = "Name"
    value               = "${local.resrc_prefix_nm}-api-ming1-asg"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "api-ming2-asg" {
  name                  = "${local.resrc_prefix_nm}-api-ming2-asg"
  vpc_zone_identifier   = [ aws_subnet.api-sn[0].id, aws_subnet.api-sn[1].id ]

  launch_template {
    id      = aws_launch_template.api-lt.id
    version = "$Latest"
  }

  target_group_arns     = [ aws_alb_target_group.api-ming2-tg8080.arn ]
  health_check_type     = "ELB"

  min_size              = var.api_lt.min_size
  max_size              = var.api_lt.max_size

  tag {
    key                 = "Name"
    value               = "${local.resrc_prefix_nm}-api-ming2-asg"
    propagate_at_launch = true
  }
}