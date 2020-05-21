resource "aws_autoscaling_group" "ui-a-asg" {
  name                  = "${local.resrc_prefix_nm}-ui-a-asg"
  vpc_zone_identifier   = var.ui-sn-id

  launch_template {
    id      = aws_launch_template.ui-lt.id
    version = "$Latest"
  }

  target_group_arns     = [ aws_alb_target_group.ui-a-tg80.arn ]
  health_check_type     = "ELB"

  min_size              = var.ui_lt.min_size
  max_size              = var.ui_lt.max_size

  tag {
    key                 = "Name"
    value               = "${local.resrc_prefix_nm}-ui-a-asg"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "ui-b-asg" {
  name                  = "${local.resrc_prefix_nm}-ui-b-asg"
  vpc_zone_identifier   = var.ui-sn-id

  launch_template {
    id      = aws_launch_template.ui-lt.id
    version = "$Latest"
  }

  target_group_arns     = [ aws_alb_target_group.ui-b-tg80.arn ]
  health_check_type     = "ELB"

  min_size              = var.ui_lt.min_size
  max_size              = var.ui_lt.max_size

  tag {
    key                 = "Name"
    value               = "${local.resrc_prefix_nm}-ui-b-asg"
    propagate_at_launch = true
  }
}