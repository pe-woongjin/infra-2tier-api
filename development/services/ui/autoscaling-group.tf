resource "aws_autoscaling_group" "ui-ming1-asg" {
  name                  = "${local.resrc_prefix_nm}-ui-ming1-asg"
  vpc_zone_identifier   = var.ui-sn-id

  launch_template {
    id      = aws_launch_template.ui-lt.id
    version = "$Latest"
  }

  target_group_arns     = [ aws_alb_target_group.ui-ming1-tg8080.arn ]
  health_check_type     = "ELB"

  min_size              = var.ui_lt.min_size
  max_size              = var.ui_lt.max_size

  tag {
    key                 = "Name"
    value               = "${local.resrc_prefix_nm}-ui-ming1-asg"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "ui-ming2-asg" {
  name                  = "${local.resrc_prefix_nm}-ui-ming2-asg"
  vpc_zone_identifier   = var.ui-sn-id

  launch_template {
    id      = aws_launch_template.ui-lt.id
    version = "$Latest"
  }

  target_group_arns     = [ aws_alb_target_group.ui-ming2-tg8080.arn ]
  health_check_type     = "ELB"

  min_size              = var.ui_lt.min_size
  max_size              = var.ui_lt.max_size

  tag {
    key                 = "Name"
    value               = "${local.resrc_prefix_nm}-ui-ming2-asg"
    propagate_at_launch = true
  }
}