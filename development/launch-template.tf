resource "aws_launch_template" "api-lt" {
  name                    = "${local.resrc_prefix_nm}-api-lt"
  image_id                = var.api_lt.id
  key_name                = var.api_lt.key_name
  instance_type           = var.api_lt.type
  vpc_security_group_ids  = [ aws_security_group.api-sg.id ]

  iam_instance_profile {
    name = "comp-codedeploy-ec2-role"
  }

  user_data = base64encode(templatefile("./ud-startup-health.tpl", {}))

  tag_specifications {
    resource_type = "instance"
    tags = {
      "Name" = "${local.resrc_prefix_nm}-api-lt"
    }
  }
}