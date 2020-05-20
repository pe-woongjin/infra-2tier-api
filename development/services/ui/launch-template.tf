resource "aws_launch_template" "ui-lt" {
  name                    = "${local.resrc_prefix_nm}-ui-lt"
  image_id                = var.ui_lt.id
  key_name                = var.ui_lt.key_name
  instance_type           = var.ui_lt.type
  vpc_security_group_ids  = [ aws_security_group.ui-sg.id ]

  // An instance profile is a container for an IAM role that you can use to pass role information to an EC2 instance when the instance starts.
  iam_instance_profile {
    name = var.ec2_role_name
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      "Name" = "${local.resrc_prefix_nm}-ui-lt"
    }
  }
}