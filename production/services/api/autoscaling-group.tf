resource "aws_autoscaling_group" "api-a-asg" {
  name                  = "${var.resrc_prefix_nm}-api-a-asg"
  vpc_zone_identifier   = [ aws_subnet.api-sn[0].id, aws_subnet.api-sn[1].id ]

  launch_template {
    id      = aws_launch_template.api-lt.id
    version = "$Latest"
  }

  target_group_arns     = [ aws_alb_target_group.api-a-tg8080.arn ]
  health_check_type     = "ELB"

  min_size              = var.api_lt.min_size
  max_size              = var.api_lt.max_size

  tag {
    key                 = "Name"
    value               = "${var.resrc_prefix_nm}-api-a-asg"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "api-b-asg" {
  name                  = "${var.resrc_prefix_nm}-api-b-asg"
  vpc_zone_identifier   = [ aws_subnet.api-sn[0].id, aws_subnet.api-sn[1].id ]

  launch_template {
    id      = aws_launch_template.api-lt.id
    version = "$Latest"
  }

  target_group_arns     = [ aws_alb_target_group.api-b-tg8080.arn ]
  health_check_type     = "ELB"

  min_size              = var.api_lt.min_size
  max_size              = var.api_lt.max_size

  tag {
    key                 = "Name"
    value               = "${var.resrc_prefix_nm}-api-b-asg"
    propagate_at_launch = true
  }
}